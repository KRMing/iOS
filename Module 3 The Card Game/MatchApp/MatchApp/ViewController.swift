//
//  ViewController.swift
//  MatchApp
//
//  Created by 이민건 on 2/24/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        // Set the view controller as the datasource and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Collection View Delegete Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        // TODO: configure it
        
        
        return cell
    }

}

