//
//  Article.swift
//  Sample-TableView
//
//  Created by 渡邊魁優 on 2023/03/29.
//

import Foundation

struct Article: Decodable {
    let title: String
    let user: User
}

struct User: Decodable {
    let name: String
    let profileImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageURL = "profile_image_url"
    }
}
