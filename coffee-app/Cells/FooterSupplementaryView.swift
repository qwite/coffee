//
//  FooterSupplementaryView.swift
//  coffee-app
//
//  Created by Artem Lashmanov on 4/4/22.
//

import UIKit

class FooterSupplementaryView: UICollectionReusableView {
    static let reuseId = "FooterSupplementaryView"
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let totalPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let makeOrderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Оплатить", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
//        button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(totalLabel)
        addSubview(totalPrice)
        addSubview(makeOrderButton)
        
        totalPrice.text = "\(Cart.sharedInstance.totalPrice) ₽"
        
        let layouts: [NSLayoutConstraint] = [
            totalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            totalLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            totalPrice.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 5),
            totalPrice.centerXAnchor.constraint(equalTo: centerXAnchor),
            makeOrderButton.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 10),
            makeOrderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            makeOrderButton.widthAnchor.constraint(equalToConstant: 200),
            makeOrderButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(layouts)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
