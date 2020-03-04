//
//  DetailViewController.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleURL: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // check that there's a url
        if articleURL != nil {
            
            // create the URL object
            let url = URL(string: articleURL!)
            
            guard url != nil else {
                
                print("couldn't instantiate url from article url: \(articleURL!)")
                return
            }
            
            // create the URLRequest object
            let request = URLRequest(url: url!)
            
            // start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
            // load it in the webview
            webView.load(request)
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // stop spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
