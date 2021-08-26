//
//  Products.swift
//  skyweb_testovoe
//
//  Created by Petar Perich on 25.08.2021.
//

import Foundation

struct Products: Decodable {
    let data: [Product]
}

struct Product: Decodable {
    let id: Int?
    let name: String?
    let ccal: Int?
    let date: String?
    let category_id: Int?
}
