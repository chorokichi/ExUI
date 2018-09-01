//
//  DemoViewController.swift
//  xcode-bot-specialist
//
//  Created by yuya on 2018/08/18.
//  Copyright © 2018年 yuya. All rights reserved.
//

import UIKit
import ExUI

class DemoViewController: BaseViewController {

    @IBOutlet weak var titleView1: ExTitleView!
    @IBOutlet weak var titleView2: ExTitleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView1.updateTitleViewText("change123456789012345678901234567890")
        titleView1.updateSubTitleViewText("sub")
        titleView2.updateTitleViewText("change2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
