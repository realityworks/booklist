//
//  UseCases.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import Foundation

class UseCases {
    private let loaderService: LoaderService
    var onBooklistLoaded: ((String?, Booklist?)->())? = nil
    
    init(_ dependencies: Dependencies = .real) {
        self.loaderService = dependencies.loaderService
    }
    
    func loadData(with query: String, nextPageToken: String? = nil) {
        loaderService.loadBooklist(with: query, nextPageToken: nil, onCompleted: { [unowned self] booklist in
            self.onBooklistLoaded?(booklist?.nextPageToken, booklist)
        })
    }
}

// Another example of how the use cases will have a set of services that we needs

extension UseCases {
    struct Dependencies {
        let loaderService: LoaderService
        
        // Here you can see how the dependencies are being tied to concrete classes
        static let real = Dependencies(loaderService: RESTLoaderService.instance)
    }
}