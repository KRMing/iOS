//
//  ViewController.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        model.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        model.getArticles()
    }
    
    // MARK: Segue Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // detect which article the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            
            print("the indexpath user has selected is nil")
            return
        }
        
        // get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // pass the article url to the detail view controller
        detailVC.articleURL = article.url!
    }
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Delegate Methods
    
    func articlesRetrieved(_ articles: [Article]) {
 
        // set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // refresh the tableview
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // TODO: customize it
        cell.displayArticle(articles[indexPath.row])
        
        // return it
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // user has just selected a row, trigger the seuge to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
    }

    // hide the article that can't display an image
}
