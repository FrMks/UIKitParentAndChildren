//
//  FamalyScreenViewModel.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import Foundation

class FamilyViewModel {
    // MARK: - Constants
    private enum Constants {
        static let nameKey = "personalData.name"
        static let ageKey = "personalData.age"
    }
    
    // MARK: - Properties
    private let userDefaults = UserDefaults.standard
    
    var onNameChanged: ((String) -> Void)?
    var onAgeChanged: ((String) -> Void)?
    
    var name: String {
        didSet {
            onNameChanged?(name)
            userDefaults.set(name, forKey: Constants.nameKey)
        }
    }
    var age: String {
        didSet {
            onAgeChanged?(age)
            userDefaults.set(age, forKey: Constants.ageKey)
        }
    }
    
    // MARK: - Initializer
    init() {
        self.name = userDefaults.string(forKey: Constants.nameKey) ?? ""
        self.age = userDefaults.string(forKey: Constants.ageKey) ?? ""
    }
    
    // MARK: - Data Persistence
    ///Loads and returns the parent's name and age from UserDefaults
    func loadData() -> PersonalData {
        let name = userDefaults.string(forKey: Constants.nameKey) ?? ""
        let age = userDefaults.string(forKey: Constants.ageKey) ?? ""
        return PersonalData(name: name, age: age)
    }
}

