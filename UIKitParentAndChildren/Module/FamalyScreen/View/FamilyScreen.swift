//
//  FamalyScreen.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

// FamilyScreen.swift

import UIKit

class FamilyScreen: UIViewController {

    // MARK: -- Properties
    private let viewModel = FamilyViewModel()
    private let childrenViewModel = ChildrenViewModel()

    //MARK: - UILabels
    let pageTitle: UILabel = {
        $0.text = "Персональные данные"
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        return $0
    }(UILabel())

    let attentionLabel: UILabel = {
        $0.text = "Дети (макс. 5)"
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        return $0
    }(UILabel())

    // MARK: - Button
    let addAChild: CircularButtonView = {
        let button = CircularButtonView(text: "+ Добавить ребенка", color: .blue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - TextFields
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

    // MARK: - TableView
    private lazy var childrenTableView: CustomTableView = {
        let tableView = CustomTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Remove the keyboard when you tap the screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        view.addSubviews(pageTitle, nameTextField, ageTextField, attentionLabel, addAChild, childrenTableView)

        setConstraints()
        setupBindings()
        loadSavedData()

        childrenTableView.setupViewModel(viewModel: childrenViewModel) //Setup viewModel here
        childrenTableView.setItems(childrenViewModel.children) // Initial load

        childrenViewModel.onChildrenChanged = { [weak self] in
            self?.childrenTableView.setItems(self?.childrenViewModel.children ?? [])
        }

        addAChild.onTap = { [weak self] in
            self?.addChildTapped()
        }
    }

    // MARK: -- Functions
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

            attentionLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            attentionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            addAChild.centerYAnchor.constraint(equalTo: attentionLabel.centerYAnchor),
            addAChild.leadingAnchor.constraint(equalTo: attentionLabel.trailingAnchor, constant: 20),
            addAChild.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -30),
            addAChild.heightAnchor.constraint(equalToConstant: 40),

            childrenTableView.topAnchor.constraint(equalTo: attentionLabel.bottomAnchor, constant: 20),
            childrenTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            childrenTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            childrenTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
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

    @objc private func addChildTapped() {
        guard let parentName = nameTextField.textField.text, !parentName.isEmpty,
              let parentAge = ageTextField.textField.text, !parentAge.isEmpty else {
            print("Имя или возраст родителя не заполнены")
            return
        }

        childrenViewModel.addChild(name: "", age: "") // Add empty child
    }
}
