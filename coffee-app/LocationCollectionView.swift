//
//  LocationTableView.swift
//  coffee-app
//
//  Created by Artem Lashmanov on 3/27/22.
//

import UIKit

class LocationCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let locationAddresses = ["Пушкинская д. 85", "Садовая д. 114", "Песочная набережная д. 14", "Малая д. 3"]
    
    init () {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(AddressCell.self, forCellWithReuseIdentifier: AddressCell.reuseId)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        locationAddresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: AddressCell.reuseId, for: indexPath)
        
        cell.backgroundColor = .systemGray
        return cell
    }
    
}
