//
//  TitleView.swift
//  xcode-bot-specialist
//
//  Created by yuya on 2018/08/18.
//  Copyright © 2018年 yuya. All rights reserved.
//

import UIKit
import ExLog

/**
 UINavigationItemのTitleViewにセットするためのクラス
 * 特徴
    - Storyboard上からも設定できる
    - TitleViewとSubTitleViewをVerticalに設置できる
    - 左右のボタンの大きさ部分のパッディングを設定できる(leftAndRightPadding)
 * 使い方
    1. NavigationItemがあるStoryboardを開く
    2. タイトルビューにUIViewをドラッグ＆ドロップする
    3. classとして”ExTitleView”を入力する
    4. moduleとして”ExUI”を入力する
 * 注意
    - CocoaPod1.5.x系の場合はPodFileにCODE_SIGNING_ALLOWEDを追加しないとstoryboardを開いたときにエラーが発生する
 */
@IBDesignable open class ExTitleView: UIView {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subTitleView: UILabel!

    /// タイトルビューのテキストをアップデートする
    public func updateTitleViewText(_ text:String){
        self.titleView.text = text
    }
    
    /// サブタイトルビューのテキストをアップデートする
    /// - 補足
    ///     * textがnil or emptyのとき隠す
    public func updateSubTitleViewText(_ text:String? = nil){
        self.subTitleView.text = text
        self.subTitleView.isHidden = text?.isEmpty ?? true
    }
    
    /// ここに設定されたピクセル部分右左にパッディングが追加される。デフォルト値は10px。(leftAndRightPadding=10なら右に10px、左に10px設定される)
    @IBInspectable var leftAndRightPadding: Int = 10
    @IBInspectable var showLog: Bool = false
    
    // コードから初期化時に呼ばれるinit
    override init(frame: CGRect) {
        super.init(frame: frame)
        loglifeCycly()
        loadFromNib()
    }

    // Storyboard及びXibから初期化時に呼ばれるinit
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loglifeCycly()
        loadFromNib()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        loglifeCycly()
        self.debugSelf()
    }

    private func loadFromNib() {
        self.debugSelf()
        // Bundle.mainだとアプリを実行している時はうまくいくがstoryboard上で描画されないので動的に決めるようにしている
        let bundle = Bundle(for: type(of: self))
        logNormal("Loaded bundle(\(String(describing: bundle.bundleIdentifier)))")
        if let titleView = bundle.loadNibNamed("ExTitleView", owner: self, options: nil)?.first as? UIView {
            logNormal("Loaded ExTitleView from nib file.")
            titleView.frame = self.bounds
            self.addSubview(titleView)
        } else {
            fatalError("Not found ExTitleView!!!")
        }
    }

    open override func updateConstraints() {
        loglifeCycly()
        self.debugSelf()
        // superは最後に呼ぶ必要がある
        super.updateConstraints()
    }
    
    open override var intrinsicContentSize: CGSize {
        loglifeCycly()
        self.debugSelf()
        return super.intrinsicContentSize
    }

    open override var bounds: CGRect {
        didSet {
            loglifeCycly()
            self.debugSelf()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        loglifeCycly()
        self.debugSelf()
        guard let base = self.superview else {
            return
        }

        if let navigationbar = base.superview as? UINavigationBar {
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
            
            if let color = navigationbar.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor{
                self.titleView.textColor = color
                self.subTitleView.textColor = color
            }
        }
    }

    
}

extension ExTitleView{
    fileprivate func debugSelf(classFile: String = #file,
                           functionName: String = #function,
                           lineNumber: Int = #line) {
        guard showLog else{
            return
        }
        
        var msg = "id: \(String(describing: self.accessibilityIdentifier))\n"
        
        msg += "\t" + "self: \(self)" + "\n"
        msg += "\t" + "titleView.translatesAutoresizingMaskIntoConstraints: \(String(describing: titleView?.translatesAutoresizingMaskIntoConstraints))" + "\n"
        msg += "\t" + "self.translatesAutoresizingMaskIntoConstraints: \(self.translatesAutoresizingMaskIntoConstraints)" + "\n"
        msg += "\t" + "self.autoresizingMask: \(self.autoresizingMask)" + "\n"
        msg += "\t" + "self.superview: \(String(describing: self.superview))" + "\n"
        msg += "\t" + "self.superview.superview: \(String(describing: self.superview?.superview))" + "\n"
        
        ExLog.log(msg, classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }
    
    fileprivate func logNormal(_ msg:String, classFile: String = #file,
                           functionName: String = #function,
                           lineNumber: Int = #line) {
        guard showLog else{
            return
        }
        ExLog.log(msg, classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }
    
    fileprivate func fatalError(_ msg:String, classFile: StaticString = #file,
                               functionName: String = #function,
                               lineNumber: UInt = #line) {
        guard showLog else{
            return
        }
        
        ExLog.fatalError(msg, classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }
    
    fileprivate func loglifeCycly(classFile: String = #file,
                              functionName: String = #function,
                              lineNumber: Int = #line) {
        logNormal("[Lyfe Cycle](id=\(String(describing: self.accessibilityIdentifier)))", classFile: classFile, functionName: functionName, lineNumber: lineNumber)
    }
}
