//
//  TitleView.swift
//  xcode-bot-specialist
//
//  Created by yuya on 2018/08/18.
//  Copyright © 2018年 yuya. All rights reserved.
//

import UIKit
//import ExLog

@IBDesignable
class TitleView: UIView {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subTitleView: UILabel!

    @IBInspectable var leftAndRightPadding: Int = 10

    // コードから初期化時に呼ばれるinit
    override init(frame: CGRect) {
        super.init(frame: frame)
        loglifeCycly()
        loadFromNib()
    }

    // Storyboard及びXibから初期化時に呼ばれるinit
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loglifeCycly()
        loadFromNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        loglifeCycly()
        self.debugSelf()
    }

    private func debugSelf(classFile: String = #file,
                           functionName: String = #function,
                           lineNumber: Int = #line) {
//        var msg = "id: \(String(describing: self.accessibilityIdentifier))\n"
//
//        msg += "\t" + "self: \(self)" + "\n"
//        msg += "\t" + "titleView.translatesAutoresizingMaskIntoConstraints: \(String(describing: titleView?.translatesAutoresizingMaskIntoConstraints))" + "\n"
//        msg += "\t" + "self.translatesAutoresizingMaskIntoConstraints: \(self.translatesAutoresizingMaskIntoConstraints)" + "\n"
//        msg += "\t" + "self.autoresizingMask: \(self.autoresizingMask)" + "\n"
//        msg += "\t" + "self.superview: \(String(describing: self.superview))" + "\n"
//        msg += "\t" + "self.superview.superview: \(String(describing: self.superview?.superview))" + "\n"
//
//        ExLog.log(msg, classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }

    private func loadFromNib() {
        self.debugSelf()
        // Bundle.mainだとアプリを実行している時はうまくいくがstoryboard上で描画されないので動的に決めるようにしている
        let bundle = Bundle(for: type(of: self))
//        ExLog.log("Loaded bundle(\(String(describing: bundle.bundleIdentifier)))")
        if let titleView = bundle.loadNibNamed("TitleView", owner: self, options: nil)?.first as? UIView {
//            ExLog.log("Loaded TitleView from nib file.")
            titleView.frame = self.bounds
            self.addSubview(titleView)
        } else {
//            ExLog.fatalError("Not found TitleView!!!")
        }
    }

    override func updateConstraints() {
        loglifeCycly()
        self.debugSelf()
        // superは最後に呼ぶ必要がある
        super.updateConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        loglifeCycly()
        self.debugSelf()
        return super.intrinsicContentSize
    }

    override var bounds: CGRect {
        didSet {
            loglifeCycly()
            self.debugSelf()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loglifeCycly()
        self.debugSelf()
        guard let base = self.superview else {
            return
        }

        if (base.superview as? UINavigationBar) != nil {
            self.translatesAutoresizingMaskIntoConstraints = true
            self.autoresizingMask = .flexibleWidth
            let frame = CGRect(
                x: CGFloat(leftAndRightPadding),
                y: 0,
                width: base.bounds.width - 2 * CGFloat(leftAndRightPadding),
                height: base.bounds.height)
            if !self.frame.equalTo(frame) {
                self.frame = frame
            }
        }
    }

    private func loglifeCycly(classFile: String = #file,
                              functionName: String = #function,
                              lineNumber: Int = #line) {
//        ExLog.log("[Lyfe Cycle](id=\(String(describing: self.accessibilityIdentifier)))", classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }
}
