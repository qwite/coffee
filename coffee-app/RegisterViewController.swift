import Foundation
import UIKit
import SPAlert

class RegisterViewController: UIViewController {
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Как вас зовут?"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func registerButtonPressed() {
        Networking.sharedInstance.registerRequest(name: nameField.text!, phone: phoneField.text!, password: passwordField.text!) { name, error in
            guard let name = name else {
                return SPAlert.present(title: "Ошибка", message: "Возникла ошибка: \(error!)", preset: .error)
            }
            
            SPAlert.present(title: "Отлично!", message: "\(name), вы успешно зарегистрировались!", preset: .done)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
       
        setupViews()
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [nameField,
                                                      phoneField,
                                                      passwordField, registerButton
                                                      ])
        stackView.spacing = 15
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout: [NSLayoutConstraint] = [
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),

            registerButton.heightAnchor.constraint(equalToConstant: 42)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
