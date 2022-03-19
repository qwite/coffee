import UIKit

class ViewController: UIViewController {

    
    private var coffeeCollectionView = CoffeeCollectionView()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Улица Пушкина д. 88"
        label.font = .boldSystemFont(ofSize: 16)
        
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
 
//        var config = UIButton.Configuration.filled()
//        config.baseBackgroundColor = .white
//        config.baseForegroundColor = .black
//        button.configuration = config
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.
//
//        let buttonAttributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
//        ]
////        button.layer.cornerRadius = 10
//        let buttonAttributedText = NSAttributedString(string: "Оформить заказ", attributes: buttonAttributes)
//        button.setAttributedTitle(buttonAttributedText, for: .normal)
//        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
        setupViews()
            
        
    
    }
    
    func setupViews() {
        
        
        view.addSubview(addressLabel)
        view.addSubview(exitButton)
        view.addSubview(makeOrderButton)
        view.addSubview(coffeeCollectionView)
        
        
        
        let layots: [NSLayoutConstraint] = [
            addressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addressLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            coffeeCollectionView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 50),
//            coffeeCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            coffeeCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            coffeeCollectionView.heightAnchor.constraint(equalToConstant: 420),
            coffeeCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            makeOrderButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            makeOrderButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -20)
            
            ]
        
        NSLayoutConstraint.activate(layots)
        
        
    }


}
