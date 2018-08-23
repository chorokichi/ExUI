//
//  BaseViewController.swift
//  xcode-bot-specialist
//
//  Created by yuya on 2018/07/31.
//  Copyright © 2018年 yuya. All rights reserved.
//

import UIKit
import ExLog

class BaseViewController: UIViewController {

    deinit {
        ExLog.log("\(String(describing: type(of: self)))\'s deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ExLog.log("\(String(describing: type(of: self)))\'s viewDidLoad")
        self.printNavigationController()
    }

    private func printNavigationController() {
        guard let navigationController = self.navigationController else {
            return
        }
        ExLog.log("\(String(describing: type(of: self)))\'s navigationController: \(String(describing: navigationController))")
        ExLog.log("\(String(describing: type(of: self)))\'s navigationController's navigationBar: \(String(describing: navigationController.navigationBar))")
        ExLog.log("\(String(describing: type(of: self)))\'s navigationItem: \(String(describing: self.navigationItem))")
        ExLog.log("\(String(describing: type(of: self)))\'s navigationItem.titleView: \(String(describing: self.navigationItem.titleView))")
        ExLog.log("\(String(describing: type(of: self)))\'s navigationItem.titleView.super: \(String(describing: self.navigationItem.titleView?.superview))")
    }

    // MARK: - Navigation
    func logPrepareInfo(for segue: UIStoryboardSegue, sender: Any?, lineNumber: Int = #line) {
        let sourceVCName = String(describing: type(of: segue.source))
        let destinationVCName = String(describing: type(of: segue.destination))
        ExLog.log("[Prepare(\(String(describing: segue.identifier)))] \(sourceVCName) => \(destinationVCName)",
            classFile: String(describing: type(of: self)), lineNumber: lineNumber)
    }
}
