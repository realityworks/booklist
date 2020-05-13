//
//  Store.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import Foundation

// We want to keep these in the store, because it's responsible for the list of facts
protocol StoreLoaderDelegate {
    func didLoadBooklist()
    func didAppendBooklist()
    var delegateName: String { get }
}

class Store {
    // Let's leave this open for test case (just to show that we can do this with the kind of initialization we are performing
    let useCases: UseCases
    
    // This would be in a seperate State class where it can be managed for storage, but for brevity we'll just keep it here.
    private (set) var booklist: Booklist? = nil
    
    // Normally we could use something like RX to manage multiple subscriptions, here we just use an array of delegates as an example
    var delegate: [StoreLoaderDelegate] = []
    
    init(useCases: UseCases) {
        self.useCases = useCases
        
        useCases.onBooklistLoaded = onBooklistLoaded(booklist:)
        useCases.onBooklistAppend = onBooklistAppend(booklist:)
    }
    
    private func onBooklistLoaded(booklist: Booklist?) {
        self.booklist = booklist
        delegate.forEach { $0.didLoadBooklist() }
    }
    
    private func onBooklistAppend(booklist: Booklist?) {
        guard let booklist = booklist else { return }
        
        self.booklist?.query = booklist.query
        self.booklist?.nextPageToken = booklist.nextPageToken
        self.booklist?.totalCount += booklist.totalCount
        self.booklist?.items.append(contentsOf: booklist.items)
        
        delegate.forEach { $0.didAppendBooklist() }
    }
}

extension Store {
    // Nice example of how we can create a singleton that supports mock objects (keeping the init public)
    // Also use lazy initialization
    static let instance: Store = {
        let store = Store(useCases: UseCases())
    
        return store
    }()
}

