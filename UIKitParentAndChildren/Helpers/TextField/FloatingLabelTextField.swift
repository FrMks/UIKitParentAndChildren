//
//  TextField.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class FloatingLabelTextField: UIView {
    // MARK: - Properties
    let textField = UITextField()
    private let titleLabel = UILabel()
    private var placeholderText: String
    // MARK: - Initializer
    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup UI
    private func setupUI() {
        setupTitleLabel()
        setupTextField()
        addBorder()
        addSubviews(titleLabel, textField)
        setConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = placeholderText
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTextField() {
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.tintColor = .black
        textField.leftViewMode = .always
        
        textField.keyboardType = (placeholderText == "Возраст") ? .numberPad : .default
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addBorder() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
