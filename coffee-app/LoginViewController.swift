import Alamofire
import Foundation

class LoginViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let lineView = UIView()
        button.setTitle("Вход", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]
        
        let buttonAttributedText = NSAttributedString(string: "Регистрация", attributes: buttonAttributes)
        button.setAttributedTitle(buttonAttributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let phoneField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Номер телефона"
        textfield.translatesAutoresizingMaskIntoConstraints = false
    
        return textfield
    }()
    
    private let passwordField: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.placeholder = "Пароль"
        textfield.translatesAutoresizingMaskIntoConstraints = false
    
        return textfield
    }()
    
    @objc func loginButtonPressed() {
        
        let network = Networking()
        network.loginRequest(phone: phoneField.text!, password: passwordField.text!) { token, error in
            
            guard let token = token else {
                return print("Some errors: \(error!)")
            }
            
            UserDefaults.standard.set(token, forKey: "token")
            UserDefaults.standard.set(true, forKey: "isAuthenticated")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.updateRootViewController()
            
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(phoneField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            phoneField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            phoneField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            phoneField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            passwordField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 10),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.leftAnchor.constraint(equalTo: phoneField.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: phoneField.rightAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 42),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
