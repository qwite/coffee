import UIKit

class CartViewController: UIViewController {

    private var cartCollectionView: UICollectionView! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Оформление заказа"
        
        view.backgroundColor = .white
        configureCollectionView()
        setupViews()
    }
    
    private func setupViews() {
        cartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cartCollectionView)

//        cartCollectionView.frame = view.frame

        let layouts: [NSLayoutConstraint] = [
            cartCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cartCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            cartCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            cartCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height),
        ]
        
        NSLayoutConstraint.activate(layouts)
    }

}
extension CartViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(OrderCell.self,
                                forCellWithReuseIdentifier: OrderCell.reuseId)
        
        collectionView.register(FooterSupplementaryView.self,
                                forSupplementaryViewOfKind: "footer",
                                withReuseIdentifier: "FooterSupplementaryView")
        
        collectionView.showsVerticalScrollIndicator = false
        cartCollectionView = collectionView
    }
    
    func setupLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createFooter()]
        let layout = UICollectionViewCompositionalLayout(section: section)
        

        return layout
    }
    
    func createFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(44))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                                 elementKind: "footer",
                                                                 alignment: .bottom)
        return footer
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cart.sharedInstance.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: "footer", withReuseIdentifier: "FooterSupplementaryView", for: indexPath) as! FooterSupplementaryView
            return footerView
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.reuseId, for: indexPath) as! OrderCell
        let orderItem = Cart.sharedInstance.items[indexPath.row]
        cell.setup(with: orderItem)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
