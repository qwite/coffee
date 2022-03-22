import UIKit

class ViewController: UIViewController {


    
    private var coffeeCollectionView = CoffeeCollectionView()

    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Улица Пушкина д. 88"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let coffeeCollectionView: UICollectionView? = {
//        var collectionView = UICollectionView()
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(CoffeeCell.self, forCellWithReuseIdentifier: "coffeeCell")
//
//        collectionView.backgroundColor = .gray
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        return collectionView
//    }()
    
    
    let exitButton: UIButton = {
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
    
    let makeOrderButton: UIButton = {
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
    
    let locationImage: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let image = UIImageView(image: UIImage(systemName: "location.fill",
                                               withConfiguration: config))
        image.tintColor = .black
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        coffeeCollectionView.coffeeDelegate = self
        
        navigationController?.navigationBar.isHidden = true
    
        setupViews()
            
        
    
    }
    
    func setupViews() {
        
        
        view.addSubview(addressLabel)
        view.addSubview(exitButton)
        view.addSubview(makeOrderButton)
        view.addSubview(coffeeCollectionView)
        view.addSubview(locationImage)
        
        let layots: [NSLayoutConstraint] = [
            addressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addressLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            locationImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationImage.leftAnchor.constraint(equalTo: addressLabel.rightAnchor, constant: 5),
            coffeeCollectionView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 50),
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


