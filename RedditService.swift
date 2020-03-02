//
//  RedditModel.swift
//  RedditListings
//
//  Created by Rahul Sharma on 1/1/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

struct RedditData: Codable {
    let kind: String
    let data: DataInfo
    
}
struct DataInfo: Codable{
    let children: [Children]
}

struct Children: Codable{
    let data: InnerData
}

struct InnerData:  Codable {
    let subreddit: String
    let name: String
    let title: String
    let url: String
    let ups: Int
    let downs: Int
    
    enum CodingKeys: String, CodingKey {
        case subreddit
        case name
        case title
        case url
        case ups
        case downs
    }
}
