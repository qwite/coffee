import UIKit

class CoffeeCell: UICollectionViewCell {
    
    static let reuseId: String = "CoffeeCell"

    private let coffeeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24,
                                       weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
                
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        let image = UIImageView.init(
            image: UIImage(systemName: "arrow.right",
                           withConfiguration: config))
        image.tintColor = .black

   
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        
        backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        layer.cornerRadius = 20
        addSubview(coffeeImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(arrowImage)
        
        let layots: [NSLayoutConstraint] = [
        coffeeImage.heightAnchor.constraint(equalToConstant: frame.width / 2),
        coffeeImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
        coffeeImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        coffeeImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        titleLabel.topAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: 20),
        titleLabel.widthAnchor.constraint(equalToConstant: frame.width),
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        priceLabel.widthAnchor.constraint(equalToConstant: frame.width),
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        arrowImage.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
        arrowImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        arrowImage.heightAnchor.constraint(equalTo: priceLabel.heightAnchor)
//        priceLabel.widthAnchor.constraint(equalToConstant: frame.width),
//        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
//        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//        arrowImage.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
//        arrowImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(layots)
    }
    
    func setup(with coffee: Coffee) {
        Networking.sharedInstance.getImage(url: coffee.image) { image, error in
            guard let image = image else {
                return print("error: \(error!)")
            }
            
            DispatchQueue.main.async {
                self.coffeeImage.image = UIImage(data: image)
                self.titleLabel.text = coffee.title
                self.descriptionLabel.text = coffee.description
                self.priceLabel.text = "\(coffee.price) ₽"
            }
        }
      }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
