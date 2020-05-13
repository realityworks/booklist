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
        var urlString = "https://api.storytel.net/search?query="
        
        urlString.append(query)
        nextPageToken.map {
            urlString.append("&page=\($0)")
        }
        
        guard let url = URL(string: urlString) else { return }
        
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

