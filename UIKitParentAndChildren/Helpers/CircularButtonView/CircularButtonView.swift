//
//  CircularButtonView.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class CircularButtonView: UIView {

    // MARK: - Properties
    private let button = UIButton(type: .system)
    private var buttonColor: UIColor
    private var buttonText: String

    var onTap: (() -> Void)?

    // MARK: - Initializers
    init(text: String, color: UIColor) {
        self.buttonText = text
        self.buttonColor = color
        super.init(frame: .zero)
        setupView()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupView() {
        setupBackground()
        setupButton()
        addSubview(button)
        setupConstraints()
    }

    private func setupBackground() {
        layer.borderColor = buttonColor.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        backgroundColor = .white
    }

    private func setupButton() {
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(buttonColor, for: .normal)
        button.tintColor = buttonColor
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.semanticContentAttribute = .forceLeftToRight
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

    // MARK: - Actions
    @objc private func buttonTapped() {
        onTap?()
    }
}

