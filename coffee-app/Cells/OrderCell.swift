import Foundation
import UIKit
import Alamofire

class OrderCell: UICollectionViewCell {
    static let reuseId: String = "OrderCell"
    
    private let coffeeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit

        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
 
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
    
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        let hStack = UIStackView(arrangedSubviews: [nameLabel, quantityLabel, sizeLabel, priceLabel])
        hStack.axis = .vertical
        hStack.distribution = .equalSpacing
        hStack.spacing = 5
        hStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        layer.cornerRadius = 20
                
        addSubview(coffeeImage)
        addSubview(hStack)
        
        
        let layouts: [NSLayoutConstraint] = [
            coffeeImage.heightAnchor.constraint(equalTo: heightAnchor),
            coffeeImage.leftAnchor.constraint(equalTo: leftAnchor),
            coffeeImage.widthAnchor.constraint(equalToConstant: frame.width / 3),
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.leftAnchor.constraint(equalTo: coffeeImage.rightAnchor, constant: 20),
            hStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

        ]
        
        NSLayoutConstraint.activate(layouts)
    }
    
     func setup(with coffee: Coffee) {
         Networking.sharedInstance.getImage(url: coffee.image) { data, error in
             guard let data = data else {
                 return print("error: \(error!)")
             }
             
             DispatchQueue.main.async {
             self.coffeeImage.image = UIImage(data: data)
             self.nameLabel.text = coffee.title
             self.quantityLabel.text = "Количество: \(coffee.quantity!)"
             self.sizeLabel.text = "Размер: \(coffee.size!)"
             self.priceLabel.text = "\(coffee.price) ₽"
             }
         }
    }
}
