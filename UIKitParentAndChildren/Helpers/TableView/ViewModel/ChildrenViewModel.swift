//
//  ChildrenViewModel.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 19.02.2025.
//

import Foundation

class ChildrenViewModel {
    // MARK: - Constants
    private enum Constants {
        static let childrenKey = "childrenData"
    }
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard

    var children: [(name: String, age: String)] = [] {
        didSet {
            saveData()
            onChildrenChanged?()
        }
    }

    var onChildrenChanged: (() -> Void)?

    // MARK: - Initializer
    init() {
        loadData()
    }

    // MARK: - Data Manipulation
    func addChild(name: String, age: String) {
        children.append((name, age))
    }
    func deleteChild(at index: Int) {
        children.remove(at: index)
    }
    func clearChildren() {
        children.removeAll()
        saveData() // Update UserDefaults
        onChildrenChanged?() // Notify about changes
    }

    // MARK: - Data Persistence
    private func saveData() {
        let childrenDictionary = children.map { ["name": $0.name, "age": $0.age] }
        userDefaults.set(childrenDictionary, forKey: Constants.childrenKey)
    }
    private func loadData() {
        guard let childrenDictionaries = userDefaults.array(forKey: Constants.childrenKey) as? [[String: String]] else {
            return
        }
        children = childrenDictionaries.map { (name: $0["name"] ?? "", age: $0["age"] ?? "")}
    }
}
