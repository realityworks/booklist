//
//  UIImageView+Extensions.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import UIKit

extension UIImageView {
    func update(with url: URL?) {
        guard let url = url else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                error == nil,
                let data = data,
                let image = UIImage(data: data) else {
                    print ("Error: \(error?.localizedDescription ?? "Unknown Error : \(url)")")
                    return
            }
            
            DispatchQueue.main.async {
                self?.image = image
                self?.contentMode = .scaleAspectFit
            }
        }.resume()
    }
}
