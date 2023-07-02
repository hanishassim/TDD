//
//  DetailViewController.swift
//  Detail
//
//  Created by Hanis on 02/07/2023.
//

import UIKit

public class DetailViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let reuseIdentifier = "Cell"
    private var data = [String]()
    
    public convenience init(data: [String]) {
        self.init()
        
        self.data = data
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setupView()
        setupListeners()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupListeners() {
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    public func popBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = data[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
}
