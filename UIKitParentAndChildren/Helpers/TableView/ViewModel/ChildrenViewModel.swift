//
//  ChildrenViewModel.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 19.02.2025.
//

import Foundation

class ChildrenViewModel {
    private let userDefaults = UserDefaults.standard
    private let childrenKey = "childrenData"
    
    var children: [(name: String, age: String)] = [] {
        didSet {
            saveData()
            onChildrenChanged?()
        }
    }
    
    var onChildrenChanged: (() -> Void)?
    
    init() {
        loadData()
    }
    
    func addChild(name: String, age: String) {
        children.append((name, age))
    }
    
    func deleteChild(at index: Int) {
        children.remove(at: index)
    }
    
    private func saveData() {
        let childrenDictionary = children.map { ["name": $0.name, "age": $0.age] }
        userDefaults.set(childrenDictionary, forKey: childrenKey)
    }
    
    private func loadData() {
        guard let childrenDictionaries = userDefaults.array(forKey: childrenKey) as? [[String: String]] else {
            return
        }
        children = childrenDictionaries.map { (name: $0["name"] ?? "", age: $0["age"] ?? "")}
    }
}
