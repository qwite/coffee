import UIKit

class CoffeeCell: UICollectionViewCell {
    
    static let reuseId: String = "CoffeeCell"
    
    let coffeeImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "caffelatte"))
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let mainView: UIView = {
        let view = UIView()
//        view.alignment = .leading
        view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
        view.layer.cornerRadius = 20
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Латте"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        label.text = "Нежное пропаренное молоко, богатый вкус эспрессо и тонкий слой молочной пены, завершающий напиток."
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "330"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mainWidth:CGFloat = frame.width
        addSubview(mainView)
        mainView.addSubview(coffeeImage)
        mainView.addSubview(titleLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(priceLabel)
        
        mainView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
//        coffeeImage.widthAnchor.constraint(equalToConstant: 205).isActive = true
        coffeeImage.heightAnchor.constraint(equalToConstant: mainWidth / 2).isActive = true
        coffeeImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30).isActive = true
        coffeeImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        coffeeImage.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
