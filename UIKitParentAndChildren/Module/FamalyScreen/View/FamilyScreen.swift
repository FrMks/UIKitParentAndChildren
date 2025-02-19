//
//  FamalyScreen.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

class FamilyScreen: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let pageTitleText = "Персональные данные"
        static let attentionLabelText = "Дети (макс. 5)"
        static let addChildButtonText = "+ Добавить ребенка"
        static let clearButtonText = "Очистить"
        static let namePlaceholder = "Имя"
        static let agePlaceholder = "Возраст"
        static let alertTitle = "Внимание"
        static let clearConfirmationTitle = "Очистить данные?"
        static let clearConfirmationMessage = "Вы уверены, что хотите удалить все данные (родители и дети)?"
        static let clearActionTitle = "Сбросить данные"
        static let cancelActionTitle = "Отмена"
        static let okActionTitle = "OK"
        static let maxChildrenAllowed = 5
        static let nameOrAgeNotFilled = "Имя или возраст родителя не заполнены"
    }

    // MARK: - Properties
    private let viewModel = FamilyViewModel()
    private let childrenViewModel = ChildrenViewModel()

    //MARK: - UIElements
    private lazy var pageTitle = setupPageTitle()
    private lazy var attentionLabel = setupAttentionLabel()
    private lazy var addAChild = setupAddChildButton()
    private lazy var clearButton = setupClearButton()
    private lazy var nameTextField = setupNameTextField()
    private lazy var ageTextField = setupAgeTextField()

    // MARK: - TableView
    private lazy var childrenTableView: CustomTableView = {
        let tableView = CustomTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        loadSavedData()
        setupChildrenTableView()
        setupButtonActions()
    }
    
    private func setupView() {
        view.backgroundColor = .white

        // Remove the keyboard when you tap the screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        view.addSubviews(pageTitle, nameTextField, ageTextField, attentionLabel, addAChild, childrenTableView, clearButton)
        setConstraints()
    }
    
    private func setupPageTitle() -> UILabel {
        let label = UILabel()
        label.text = Constants.pageTitleText
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }
    private func setupAttentionLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.attentionLabelText
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }
    private func setupAddChildButton() -> CircularButtonView {
        let button = CircularButtonView(text: Constants.addChildButtonText, color: .blue)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private func setupClearButton() -> CircularButtonView {
        let button = CircularButtonView(text: Constants.clearButtonText, color: .red)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private func setupNameTextField() -> FloatingLabelTextField {
        let textField = FloatingLabelTextField(placeholder: Constants.namePlaceholder)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        return textField
    }
    private func setupAgeTextField() -> FloatingLabelTextField {
        let textField = FloatingLabelTextField(placeholder: Constants.agePlaceholder)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textField.addTarget(self, action: #selector(ageTextFieldDidChange), for: .editingChanged)
        return textField
    }
    ///Set up the table and initialing the table that displays child data
    private func setupChildrenTableView() {
        childrenTableView.setupViewModel(viewModel: childrenViewModel)
        childrenTableView.setItems(childrenViewModel.children)
        
        childrenViewModel.onChildrenChanged = { [weak self] in
            self?.childrenTableView.setItems(self?.childrenViewModel.children ?? [])
        }
    }
    private func setupButtonActions() {
        addAChild.onTap = { [weak self] in
            self?.addChildTapped()
        }

        clearButton.onTap = { [weak self] in
            self?.showClearConfirmation()
        }
    }

    // MARK: - Constraints
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

            clearButton.topAnchor.constraint(equalTo: childrenTableView.bottomAnchor, constant: 20),
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            clearButton.heightAnchor.constraint(equalToConstant: 40),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    // MARK: - Bindings
    private func setupBindings() {
        // Listen for changes from the ViewModel
        viewModel.onNameChanged = { [weak self] name in
            self?.nameTextField.textField.text = name
        }

        viewModel.onAgeChanged = { [weak self] age in
            self?.ageTextField.textField.text = age
        }
    }
    // MARK: - Data Loading
    private func loadSavedData() {
        let data = viewModel.loadData()
        nameTextField.textField.text = data.name
        ageTextField.textField.text = data.age
    }
    
    private func validateParentChildAge() -> Bool {
        guard let parentAgeInt = Int(viewModel.age) else { return true }
        
        for (index, child) in childrenViewModel.children.enumerated() {
            if let childAgeInt = Int(child.age), childAgeInt >= parentAgeInt {
                childrenViewModel.children[index].age = ""
                showAlert(message: "Возраст родителя должен быть больше возраста ребенка")
                return false
            }
        }
        return true
    }



    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        saveParentData()
        _ = validateParentChildAge()
    }

    @objc private func nameTextFieldDidChange() {
        viewModel.name = nameTextField.textField.text ?? ""
    }
    @objc private func ageTextFieldDidChange() {
        viewModel.age = ageTextField.textField.text ?? ""
    }
    private func saveParentData() {
        viewModel.name = nameTextField.textField.text ?? ""
        viewModel.age = ageTextField.textField.text ?? ""
    }
    ///Validating parent information and managing the children limit
    @objc private func addChildTapped() {
        guard let parentName = nameTextField.textField.text, !parentName.isEmpty,
              let parentAge = ageTextField.textField.text, !parentAge.isEmpty else {
            print(Constants.nameOrAgeNotFilled)
            return
        }

        //Check children limit
        if childrenViewModel.children.count < 5 {
             childrenViewModel.addChild(name: "", age: "") // Add empty child
        } else {
            //Show alert if children limit > 5
            showAlert(message: "Достигнуто максимальное количество детей (5).")
        }
    }

    // MARK: - Alerts
    //Show Action Sheet
    private func showClearConfirmation() {
        let alertController = UIAlertController(title: Constants.clearActionTitle,
                                                message: Constants.clearConfirmationMessage,
                                                preferredStyle: .actionSheet)

        let clearAction = UIAlertAction(title: Constants.cancelActionTitle, style: .destructive) { [weak self] _ in
            self?.clearAllData()
        }
        let cancelAction = UIAlertAction(title: Constants.cancelActionTitle, style: .cancel, handler: nil)

        alertController.addAction(clearAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    // Show Alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okActionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: - Data Manipulation
    private func clearAllData() {
        //Clear parent data
        viewModel.name = ""
        viewModel.age = ""
        nameTextField.textField.text = ""
        ageTextField.textField.text = ""

        //Clear children data
        childrenViewModel.clearChildren()
    }
}
