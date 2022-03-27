import UIKit

class ViewController: UIViewController {

    private var coffeeCollectionView = CoffeeCollectionView()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        
        let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]
        
        let buttonAttributedText = NSAttributedString(string: "Выход", attributes: buttonAttributes)
        button.setAttributedTitle(buttonAttributedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let makeOrderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        coffeeCollectionView.coffeeDelegate = self
    
        setupViews()
    }
        
    func setupViews() {
        
        title = "Улица Пушкина д. 88"
        
        navigationItem.backButtonTitle = ""
        
        // setting titleView
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = title
        let hStack = UIStackView(arrangedSubviews: [titleLabel, imageView])
        hStack.spacing = 5
        navigationItem.titleView = hStack
        
        view.addSubview(exitButton)
        view.addSubview(makeOrderButton)
        view.addSubview(coffeeCollectionView)
        
        let layots: [NSLayoutConstraint] = [
            coffeeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            coffeeCollectionView.heightAnchor.constraint(equalToConstant: 420),
            coffeeCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            makeOrderButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            makeOrderButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -20),
            makeOrderButton.widthAnchor.constraint(equalToConstant: 200),
            makeOrderButton.heightAnchor.constraint(equalToConstant: 42)
            ]
        
        NSLayoutConstraint.activate(layots)
        
    }
    
}

extension ViewController: CoffeeCollectionViewDelegate {
    func pushController(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


