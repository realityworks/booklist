//
//  Booklist.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import Foundation

struct Booklist: Decodable {
    let query: String
    let filter: String
    let nextPageToken: String
    let totalCount: Int
    
    let book: [Book]
    
    struct Book: Decodable {
        let title: String
        let authors: [Author]
        let cover: [Cover]
        
        struct Author: Decodable {
            let name: String
        }
        
        struct Cover: Decodable {
            let url: String
        }
    }
}
