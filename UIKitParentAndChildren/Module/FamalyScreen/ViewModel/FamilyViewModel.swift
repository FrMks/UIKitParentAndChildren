//
//  FamalyScreenViewModel.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import Foundation

class FamilyViewModel {
    private let userDefaults = UserDefaults.standard
    private let nameKey = "personalData.name"
    private let ageKey = "personalData.age"
    
    var onNameChanged: ((String) -> Void)?
    var onAgeChanged: ((String) -> Void)?
    
    var name: String {
        didSet {
            onNameChanged?(name)
            userDefaults.set(name, forKey: nameKey)
            userDefaults.synchronize() // Force synchronization
        }
    }
    
    var age: String {
        didSet {
            onAgeChanged?(age)
            userDefaults.set(age, forKey: ageKey)
            userDefaults.synchronize() // Force synchronization
        }
    }
    
    init() {
        self.name = userDefaults.string(forKey: nameKey) ?? ""
        self.age = userDefaults.string(forKey: ageKey) ?? ""
    }
    
    func saveData() {
        userDefaults.set(name, forKey: nameKey)
        userDefaults.set(age, forKey: ageKey)
        userDefaults.synchronize() // Force synchronization
    }
    
    func loadData() -> PersonalData {
        let name = userDefaults.string(forKey: nameKey) ?? ""
        let age = userDefaults.string(forKey: ageKey) ?? ""
        return PersonalData(name: name, age: age)
    }
}

