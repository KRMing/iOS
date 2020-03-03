//
//  ScoreResultVC.swift
//  CardApp(Practice2)
//
//  Created by 이민건 on 3/1/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ScoreResultVC: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    
    var scores: [TimeInterval]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = true
    }
    
}

extension ScoreResultVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if scores == nil {
            
            return 0
        }
        
        return scores!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        
        let label = cell?.viewWithTag(1) as? UILabel
        
        label?.text = String(format: "#\(indexPath.row + 1) : %2.f", Double(scores![indexPath.row]) / 1000.0)
        
        cell?.layer.cornerRadius = 5
        cell?.layer.masksToBounds = true
        
        return cell!
    }
}
