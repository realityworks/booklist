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
        let stackView = UIStackView()
        let containerView = UIView()
        
        contentView.addSubview(containerView)
        containerView.topToSuperview()
        containerView.bottomToSuperview()
        containerView.leftToSuperview(offset: 16)
        containerView.rightToSuperview(offset: -16)
        containerView.height(60)
        
        containerView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.edgesToSuperview()
        
        label.text = "Query: "
        label.width(100)
        
        textField.backgroundColor = .white
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
