//
//  FamalyScreen.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class FamalyScreen: UIViewController {
    
    //MARK: Properties
    let pageTitle: UILabel = {
        $0.text = "Персональные данные"
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 24, weight: .medium)
        return $0
    }(UILabel())
    
    //MARK: TextFields
    private lazy var nameTextField: UIView = {
        let textField = FloatingLabelTextField(placeholder: "Имя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var ageTextField: UIView = {
        let textField = FloatingLabelTextField(placeholder: "Возраст")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubviews(pageTitle, nameTextField, ageTextField)
        
        setConstraints()
    }
    
    //MARK: Functions
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
