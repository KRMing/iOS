//
//  Article.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

struct Article: Decodable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}
