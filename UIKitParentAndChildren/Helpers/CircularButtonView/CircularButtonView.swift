//
//  CircularButtonView.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class CircularButtonView: UIView {
    private let button = UIButton(type: .system)
    
    var onTap: (() -> Void)?
    
    init(text: String, color: UIColor) {
        super.init(frame: .zero)
        
        setupView(text: text, color: color)
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(text: String, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        backgroundColor = .white
        
        setupLabel(text: text, color: color)
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupLabel(text: String, color: UIColor) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.tintColor = color
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.semanticContentAttribute = .forceLeftToRight
        //button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupActions() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}
