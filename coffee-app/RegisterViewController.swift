import Foundation
import UIKit

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
        let lineView = UIView()
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
                let errorAlert = UIAlertController(title: "Error", message: "\(error!)", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    // ok action
                }))
                debugPrint(error!)
                return self.present(errorAlert, animated: true, completion: nil)
            }
            
            let successAlert = UIAlertController(title: "Отлично!", message: "\(name), вы успешно зарегистрированы!", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(successAlert, animated: true, completion: nil)

        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [nameField,
                                                      phoneField,
                                                      passwordField
                                                      ])
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.axis = .vertical
        view.addSubview(stackView)
        view.addSubview(registerButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout: [NSLayoutConstraint] = [
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor),
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 42)
        ]
        
        NSLayoutConstraint.activate(layout)
    }
}
