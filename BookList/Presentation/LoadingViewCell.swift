//
//  LoadingViewCell.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import UIKit

import TinyConstraints

class LoadingViewCell: UITableViewCell {
    
    static let identifier = "LoadingViewCell"

    private let loadingIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup the UI Components
        let containerView = UIView()
        contentView.addSubview(containerView)
        
        containerView.edgesToSuperview()
        containerView.height(60)
        
        containerView.addSubview(loadingIndicator)
        loadingIndicator.centerInSuperview()
        loadingIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
    }
}
