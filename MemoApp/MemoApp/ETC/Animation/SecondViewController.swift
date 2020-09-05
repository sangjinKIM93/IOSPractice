//
//  SecondViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/08/27.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
