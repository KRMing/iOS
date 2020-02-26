//
//  Department.swift
//  LS04 Exercise
//
//  Created by 이민건 on 2/26/20.
//  Copyright © 2020 KRMing. All rights reserved.
//

import Foundation

struct Department: Decodable {
    
    var name: String?
    var employees: [Person]?
}
