//
//  Booklist.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import Foundation

struct Booklist: Decodable {
    var query: String
    var filter: String
    var nextPageToken: String
    var totalCount: Int
    
    var items: [Book]
    
    struct Book: Decodable {
        let title: String
        let authors: [Author]
        let cover: Cover
        
        struct Author: Decodable {
            let name: String
        }
        
        struct Cover: Decodable {
            let url: String
        }
    }
}
