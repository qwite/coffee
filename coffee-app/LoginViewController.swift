import Alamofire
import Foundation

class LoginViewController: UIViewController {
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Заказать кофе. \nЗдесь. \nСейчас"
        label.font = UIFont.systemFont(ofSize: 46,
                                       weight: .bold)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        let buttonAttributedText = NSAttributedString(string: "Регистрация", attributes: buttonAttributes)
        button.setAttributedTitle(buttonAttributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let phoneField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Номер телефона"
        textfield.keyboardType = .phonePad
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
        Networking.sharedInstance.loginRequest(phone: phoneField.text!, password: passwordField.text!) { token, error in
            
            guard let token = token else {
                let alert = UIAlertController(title: "Error", message: "\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    // ok action
                }))
                return self.present(alert, animated: true, completion: nil)
            }
            
            UserDefaults.standard.set(token, forKey: "token")
            UserDefaults.standard.set(true, forKey: "isAuthenticated")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.updateRootViewController()
            
        }
    }
    
    @objc func registerButtonPressed() {
        self.present(RegisterViewController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        
        let stackView = UIStackView(arrangedSubviews: [phoneField,
                                                       passwordField,
                                                       loginButton
                                                   ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
//            loginButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
//            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
}
