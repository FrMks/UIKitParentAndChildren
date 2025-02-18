//
//  TextField.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class FloatingLabelTextField: UIView {
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    init(placeholder: String) {
        super.init(frame: .zero)
        setupUI(placeholder: placeholder)
    }
    
    private func setupUI(placeholder: String) {// Настройка заголовка (верхний статичный текст)
        setupTitle(placeholder: placeholder)
        setupTextField()
        
        addBorder()
        
        addSubviews(titleLabel, textField)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    private func setupTitle(placeholder: String) {
        titleLabel.text = placeholder
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    private func setupTextField() {
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.tintColor = .black
        textField.leftViewMode = .always
    }
    
    private func addBorder() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
