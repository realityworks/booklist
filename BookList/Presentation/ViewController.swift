//
//  ViewController.swift
//  BookList
//
//  Created by Piotr Suwara on 10/4/20.
//  Copyright © 2020 Realityworks. All rights reserved.
//

import UIKit

import TinyConstraints

class ViewController: UIViewController {
    // MARK: Model
    let viewModel: ViewModel = ViewModel()

    // MARK: View
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        style()
        configure()
    }

    private func style() {
        // Setup the UI Components how we want them
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 140
        tableView.estimatedSectionHeaderHeight = 60
        
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = .none

        title = "StoryTel"
    }

    private func configure() {
        // Setup data bindings and registrations
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(LoadingViewCell.self, forCellReuseIdentifier: LoadingViewCell.identifier)
        tableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: TableHeader.identifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to reload")
        refreshControl.addTarget(self, action: #selector(reload), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        viewModel.listenForUpdates(delegate: self)
    }
    
    @objc
    private func reload(sender: AnyObject) {
        viewModel.load()
        self.refreshControl.endRefreshing()
    }
    
    @objc
    private func queryDidEdit(sender: UITextField) {
    }
    
    @objc
    private func queryEditDidEnd(sender: UITextField) {
        viewModel.query = sender.text ?? ""
        sender.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfBooks > 0 ? viewModel.numberOfBooks + 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < viewModel.numberOfBooks {
            guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else { return UITableViewCell() }
            
            if let book = viewModel.getBook(at: indexPath.row) {
                cell.configure(with: book)
            }
            
            return cell
        } else {
            guard let cell: LoadingViewCell = tableView.dequeueReusableCell(withIdentifier: LoadingViewCell.identifier) as? LoadingViewCell else { return UITableViewCell() }
            viewModel.loadNextPage()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeader.identifier) as? TableHeader else { return nil }
        
        header.textField.text = viewModel.query
        header.textField.addTarget(self, action: #selector(queryDidEdit), for: .editingChanged)
        header.textField.addTarget(self, action: #selector(queryEditDidEnd), for: [.editingDidEnd])

        return header
    }
}

extension ViewController: StoreLoaderDelegate {
    func didLoadBooklist() {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    var delegateName: String { "\(self)"}
}
