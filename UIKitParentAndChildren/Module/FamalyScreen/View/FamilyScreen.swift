//
//  FamalyScreen.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class FamilyScreen: UIViewController {
    
    // MARK: - Properties
    private let viewModel = FamilyViewModel()
    
    let pageTitle: UILabel = {
        $0.text = "Персональные данные"
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 24, weight: .medium)
        return $0
    }(UILabel())
    
    // MARK: TextFields
    private lazy var nameTextField: FloatingLabelTextField = {
        let textField = FloatingLabelTextField(placeholder: "Имя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var ageTextField: FloatingLabelTextField = {
        let textField = FloatingLabelTextField(placeholder: "Возраст")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.addTarget(self, action: #selector(ageTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Remove the keyboard when you tap the screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        view.addSubviews(pageTitle, nameTextField, ageTextField)
        
        setConstraints()
        setupBindings()
        loadSavedData()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        // Listen for changes from the ViewModel
        viewModel.onNameChanged = { [weak self] name in
            self?.nameTextField.textField.text = name
        }
        
        viewModel.onAgeChanged = { [weak self] age in
            self?.ageTextField.textField.text = age
        }
    }
    
    private func loadSavedData() {
        let data = viewModel.loadData()
        nameTextField.textField.text = data.name
        ageTextField.textField.text = data.age
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        // Save data when keyboard is dismissed
        if let name = nameTextField.textField.text {
            viewModel.name = name
        }
        if let age = ageTextField.textField.text {
            viewModel.age = age
        }
    }
    
    @objc private func nameTextFieldDidChange() {
        if let name = nameTextField.textField.text {
            viewModel.name = name
        }
    }
    
    @objc private func ageTextFieldDidChange() {
        if let age = ageTextField.textField.text {
            viewModel.age = age
        }
    }
    
    // MARK: - Functions
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            nameTextField.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            ageTextField.heightAnchor.constraint(equalToConstant: 60),
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    
}


