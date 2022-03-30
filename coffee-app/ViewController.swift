import UIKit

class ViewController: UIViewController {

    private var coffeeCollectionView: UICollectionView! = nil
    
    private var coffeeItemsArray: [Coffee] = {
        var latte = Coffee(
            title: "Латте",
            description: "Нежное пропаренное молоко, богатый вкус эспрессо и тонкий слой молочной пены, завершающий напиток.",
            image: "caffelatte",
            price: 330)
        
        var cappuccino = Coffee(
            title: "Капучино",
            description: "Кофейный напиток итальянской кухни на основе эспрессо с добавлением в него подогретого вспененного молока.",
            image: "cappuccino",
            price: 230)
        
        var caramelMacchiato = Coffee(
            title: "Карамельный Маккиато",
            description: "Пропаренное молоко в сочетании с ванильным сиропом и насыщенным эспрессо.",
            image: "caramelmacchiato",
            price: 400)
        
        var espressoMint = Coffee(
            title: "Эспрессо-тоник с мятой",
            description: "Холодный и бодрящий эспрессо-тоник, идеально сочетающий в себе кофе.",
            image: "espressomint",
            price: 300)
        
        return [latte, cappuccino, caramelMacchiato, espressoMint]
    }()
    
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
        button.addTarget(self, action: #selector(makeOrder), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        setupViews()
    }
    
    @objc func makeOrder () {
        navigationController?.pushViewController(LocationViewController(), animated: true)
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
            coffeeCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
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

extension ViewController {
    func configureCollectionView () {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CoffeeCell.self, forCellWithReuseIdentifier: CoffeeCell.reuseId)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        coffeeCollectionView = collectionView
    }
    
    func setupLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                      leading: padding,
                                                      bottom: 0,
                                                      trailing: padding)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pushController(controller: CoffeeDetailViewController(item: coffeeItemsArray[indexPath.row]))
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeItemsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeCell.reuseId, for: indexPath) as! CoffeeCell
        let coffeeItem = coffeeItemsArray[indexPath.row]
        cell.setup(with: coffeeItem)
        
        return cell
    }
    
}


