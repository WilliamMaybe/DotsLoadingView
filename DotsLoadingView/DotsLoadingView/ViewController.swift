//
//  ViewController.swift
//  DotsLoadingView
//
//  Created by zhangyi on 16/5/25.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loadingView = DotsLoadingView()
        view.addSubview(loadingView)
        loadingView.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

