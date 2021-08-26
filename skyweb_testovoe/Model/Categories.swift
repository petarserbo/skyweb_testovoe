//
//  Categories.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 25.08.2021.
//

import Foundation


struct Categories: Codable {
    let data: [Category]
}

struct Category: Codable {
    let id: Int?
    let name: String?
    let unit: String?
    let count: Int?
    
}
