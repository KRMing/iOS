//
//  ArticleService.swift
//  NewsApp
//
//  Created by 이민건 on 3/4/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

struct ArticleService: Decodable {
    
    var totalResults: Int?
    var articles: [Article]?
}
