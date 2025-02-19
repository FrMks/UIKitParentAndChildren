//
//  CustomTableViewCell.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 19.02.2025.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"

    private let nameTextField = FloatingLabelTextField(placeholder: "Имя")
    private let ageTextField = FloatingLabelTextField(placeholder: "Возраст")

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    //Closure for delete
    var onDelete: (() -> Void)?

    // Closure to notify of changes
    var onNameChanged: ((String) -> Void)?
    var onAgeChanged: ((String) -> Void)?

    //Index Path
    var indexPath: IndexPath?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
        setupTextFieldTargets()  // Add this line
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        contentView.addSubviews(nameTextField, ageTextField, deleteButton)

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.backgroundColor = .white
        nameTextField.backgroundColor = .white
        ageTextField.backgroundColor = .white

        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),

            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            ageTextField.heightAnchor.constraint(equalToConstant: 60),

            deleteButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }

    private func setupActions() {
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    // Add this function
    private func setupTextFieldTargets() {
        nameTextField.textField.addTarget(self, action: #selector(nameTextFieldDidEndEditing), for: .editingDidEnd)
        ageTextField.textField.addTarget(self, action: #selector(ageTextFieldDidEndEditing), for: .editingDidEnd)

    }

    @objc private func deleteTapped() {
        onDelete?()
    }

    @objc private func nameTextFieldDidEndEditing() {
        onNameChanged?(nameTextField.textField.text ?? "") // Notify of name change
    }

    @objc private func ageTextFieldDidEndEditing() {
        onAgeChanged?(ageTextField.textField.text ?? "") // Notify of age change
    }

    func configure(name: String, age: String) {
        nameTextField.textField.text = name
        ageTextField.textField.text = age
        print("Настройка ячейки для: \(name), \(age) лет")
    }
}
