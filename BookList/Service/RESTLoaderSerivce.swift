//
//  RESTLoaderSerivce.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import Foundation

class RESTLoaderService: LoaderService {
    func loadBooklist(with query: String, nextPageToken: String?, onCompleted: @escaping (Booklist?)->Void) {
        let urlString = "https://api.storytel.net/search?query="
        guard var url = URL(string: urlString) else { return }
        
        url.appendPathComponent(query)
        nextPageToken.map {
            url.appendPathComponent("&page=\($0)")
        }
        
        // Just use a URL Request here, we may need to update headers, or type
        URLSession.shared.dataTask(with: url) { data, response, urlError in
            // Check the URL was read correctly
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                urlError == nil,
                let data = data else {
                    print ("Error: \(urlError?.localizedDescription ?? "UnknownHTTPError")")
                    onCompleted(nil)
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                //let text = String(data: data, encoding: .windowsCP1252)
                //if let dataFromString = text?.data(using: .utf8, allowLossyConversion: false) {
                let booklist = try decoder.decode(Booklist.self, from: data)
                onCompleted(booklist)

            } catch {
                print ("Failed Decoding \(error)")
            }
        }.resume()
    }
}


// Setup an instance provider here

extension RESTLoaderService {
    static let instance: RESTLoaderService = {
        RESTLoaderService()
    }()
}

