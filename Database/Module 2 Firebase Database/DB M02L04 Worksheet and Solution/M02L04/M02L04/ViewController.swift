//
//  ViewController.swift
//  M02L04
//
//  Created by 이민건 on 3/6/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        var timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (t: Timer) in
//
//            self.label.alpha += 0.1
//
//            if self.label.alpha >= 1 {
//
//                t.invalidate()
//            }
//        }
        
        UIView.animate(withDuration: 3, animations: {
            
            self.label.alpha = 1
        }) { (completed: Bool) in
            
            self.label.text = "done"
        }
    }
}

