//
//  CacheManager.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String: Data]()
    
    static func saveData(_ url: String, _ imageData: Data){
    
        // save the image data along with the url
        imageDictionary[url] = imageData
        
    }
    
    static func retrieveData(_ url: String) -> Data? {
        
        // return the saved image data or nil
        return imageDictionary[url]
    }
}
