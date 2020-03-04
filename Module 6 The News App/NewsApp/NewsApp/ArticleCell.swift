//
//  ArticleCell.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay: Article?
    
    func displayArticle(_ article: Article) {
        
        // clean up the cell before displaying the next article
        headlineLabel.text = ""
        articleImageView.image = nil
        
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        
        // animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
        }, completion: nil)
        
        // keep a reference to the article
        articleToDisplay = article
        
        // set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // download and display the image
        
        // check that the article actually has an image
        
        guard articleToDisplay!.urlToImage != nil else {
            
            print("there is no image to diplay for article: \(articleToDisplay?.title)")
            return
        }
        
        // create a url string
        let urlString = articleToDisplay!.urlToImage!

        // check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // there is image data, set the image view and return
            articleImageView.image = UIImage(data: imageData)
            
            // animate the image into view
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
            }, completion: nil)
            
            return
        }
        
        // create the url
        let url = URL(string: urlString)

        // check that the url isn't nill
        guard url != nil else {
            
            print("couldn't instantiate url from url string: \(urlString)")
            return
        }
        
        // get a url session
        let session = URLSession.shared
        
        // create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check if the url string that the data task went off to download matches the article this cell is set to display
            if self.articleToDisplay?.urlToImage == urlString {
                
                // check that there were no errors
                if data != nil && error == nil {
                    
                    CacheManager.saveData(urlString, data!)
                    
                    DispatchQueue.main.async {
                        
                        // display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        // animate the image into view
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                        }, completion: nil)
                    }
                }
            }
            
        }
        
        // kick off the datatask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
