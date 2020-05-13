//
//  TableHeader.swift
//  BookList
//
//  Created by Piotr Suwara on 13/5/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import UIKit


class TableHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    let label = UILabel()
    let textField = UITextField()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .search
        
        // Add components
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.alignment = .fill
        containerView.spacing = 8
        containerView.edgesToSuperview()
        containerView.height(150)
        
        contentView.addSubview(containerView)
        
        label.text = "Query: "
        label.width(50)
        
        containerView.addSubview(label)        
        containerView.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
