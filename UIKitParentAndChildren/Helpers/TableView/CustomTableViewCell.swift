//
//  CustomTableViewCell.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 19.02.2025.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - Constants
    static let identifier = "CustomTableViewCell"

    // MARK: - Properties
    private let nameTextField = FloatingLabelTextField(placeholder: "Имя")
    private let ageTextField = FloatingLabelTextField(placeholder: "Возраст")

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        return button
    }()

    // Closures
    var onDelete: (() -> Void)?
    var onNameChanged: ((String) -> Void)?
    var onAgeChanged: ((String) -> Void)?

    // Index Path
    var indexPath: IndexPath?

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupActions()
        setupTextFieldTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupView() {
        contentView.addSubviews(nameTextField, ageTextField, deleteButton)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false

        contentView.backgroundColor = .white
        nameTextField.backgroundColor = .white
        ageTextField.backgroundColor = .white

        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),

            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            ageTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            ageTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),

            deleteButton.topAnchor.constraint(equalTo: nameTextField.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    private func setupActions() {
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    private func setupTextFieldTargets() {
        nameTextField.textField.addTarget(self, action: #selector(nameTextFieldDidEndEditing), for: .editingDidEnd)
        ageTextField.textField.addTarget(self, action: #selector(ageTextFieldDidEndEditing), for: .editingDidEnd)

    }

    // MARK: - Actions
    @objc private func deleteTapped() {
        onDelete?()
    }

    @objc private func nameTextFieldDidEndEditing() {
        onNameChanged?(nameTextField.textField.text ?? "")
    }

    @objc private func ageTextFieldDidEndEditing() {
        onAgeChanged?(ageTextField.textField.text ?? "")
    }

    // MARK: - Configuration
    func configure(name: String, age: String) {
        nameTextField.textField.text = name
        ageTextField.textField.text = age
        print("Настройка ячейки для: \(name), \(age) лет")
    }
}
