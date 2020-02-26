//
//  ViewController.swift
//  LS04 Exercise
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "LS03 Exercise", ofType: ".json")
        
        guard path != nil else {
            print("error in assigning path")
            return
        }
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            let array = try decoder.decode([Department].self, from: data)
            
            print(array)
        }
        catch {
            print("couldn't create data object from file")
        }
    }


}

