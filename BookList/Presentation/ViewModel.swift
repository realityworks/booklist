//
//  ViewModel.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import UIKit

class ViewModel {
    
    private let store: Store
    private let useCases: UseCases
    
    var query: String = ""
    
    init(_ dependencies: Dependencies = .real) {
        self.store = dependencies.store
        self.useCases = dependencies.useCases
    }
    
    func load() {
        useCases.loadData(with: query)
    }
    
    func loadNextPage() {
        guard let nextPageToken = store.booklist?.nextPageToken else { return }
        useCases.loadNextDataNext(with: query, nextPageToken: nextPageToken)
    }
    
    func listenForUpdates(delegate: StoreLoaderDelegate) {
        store.delegates.append(delegate)
    }
    
    func stopListeningForUpdates(delegate: StoreLoaderDelegate) {
        store.delegates.removeAll { $0.delegateName == delegate.delegateName }
    }
    
    func getBook(at index: Int) -> Booklist.Book? {
        guard index < store.booklist?.items.count ?? 0 else { return nil }
        return store.booklist?.items[index]
    }
}

// MARK: Computed properties
extension ViewModel {
    var numberOfBooks: Int {
        store.booklist?.items.count ?? 0
    }    
}


// Let's use a nice clean dependencies structure that wraps all of our needs into one argument. Instead of passing a collection of arguments to the view model.

// In a larger project, you would have more transports and use cases. Each one with a single responsibility.

// MARK: Dependencies
extension ViewModel {
    struct Dependencies {
        let store: Store
        let useCases: UseCases
        
        static var real = Dependencies(
            store: Store.instance,
            useCases: Store.instance.useCases)
    }
}
