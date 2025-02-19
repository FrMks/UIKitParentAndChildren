//
//  CustomTableView.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 19.02.2025.
//

import UIKit

class CustomTableView: UIView, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    private let tableView = UITableView()
    private var items: [(name: String, age: String)] = []
    weak var childrenViewModel: ChildrenViewModel?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupView() {
        setupTableView()
        setupConstraints()
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.backgroundColor = .white
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Configuration
    func setItems(_ newItems: [(name: String, age: String)]) {
        self.items = newItems
        tableView.reloadData()
    }

    func setupViewModel(viewModel: ChildrenViewModel) {
        self.childrenViewModel = viewModel
    }

    // MARK: - Data Manipulation
    func addItem(name: String, age: String) {
        childrenViewModel?.addChild(name: name, age: age)
        items = childrenViewModel?.children ?? []
        tableView.reloadData()
    }

    private func deleteItem(at index: Int) {
        childrenViewModel?.deleteChild(at: index)
        items = childrenViewModel?.children ?? []
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell,
              let childrenViewModel = childrenViewModel else {
            return UITableViewCell()
        }

        let index = indexPath.row
        let child = childrenViewModel.children[index]

        cell.configure(name: child.name, age: child.age)
        cell.indexPath = indexPath

        cell.onNameChanged = { [weak self] newName in
            guard let self = self, let indexPath = cell.indexPath else { return }
            self.childrenViewModel?.children[indexPath.row].name = newName
            self.items = self.childrenViewModel?.children ?? []
        }

        cell.onAgeChanged = { [weak self] newAge in
            guard let self = self, let indexPath = cell.indexPath else { return }
            self.childrenViewModel?.children[indexPath.row].age = newAge
            self.items = self.childrenViewModel?.children ?? []
        }

        cell.onDelete = { [weak self] in
            self?.deleteItem(at: indexPath.row)
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

