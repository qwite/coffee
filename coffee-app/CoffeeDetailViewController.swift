//
//  CoffeeDetailViewController.swift
//  coffee-app
//
//  Created by Artem Lashmanov on 3/21/22.
//

import UIKit

class CoffeeDetailViewController: UIViewController {

    let coffeeImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "caffelatte"))
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24,
                                       weight: .bold)
        label.text = "Латте"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
        
        label.text = "Нежное пропаренное молоко, богатый вкус эспрессо и тонкий слой молочной пены, завершающий напиток."
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "330₽"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    func setupViews () {
        view.addSubview(coffeeImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
    }
    


}

extension CoffeeDetailViewController: UICollectionViewDelegate {
    
}
