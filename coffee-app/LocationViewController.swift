import UIKit

class LocationViewController: UIViewController {

    private var locationCollectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Address>?
    

    private let addressArray: [Address] = [
        Address(title: "Пушкинская д. 85"),
        Address(title: "Садовая д. 114"),
        Address(title: "Песочная набережная д. 14"),
        Address(title: "Малая д. 3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureCollectionView()
        applyInitialSnapshots(with: addressArray)
        setupViews()
        
      
                
    }
    
    func setupViews() {
        
        let selectedId = dataSource?.indexPath(for: Address(title: "Пушкинская д. 85"))
        locationCollectionView.selectItem(at: selectedId, animated: false, scrollPosition: .centeredHorizontally)
        
        view.addSubview(locationCollectionView)
        NSLayoutConstraint.activate([
            locationCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            locationCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            locationCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension LocationViewController {
    enum Section{
        case main
    }
}

extension LocationViewController {
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Address> { cell, indexPath, address in
            var content = cell.defaultContentConfiguration()
            content.text = "\(address.title)"
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Address>(collectionView: collectionView) { collectionView, indexPath, address in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: address)
        }
        
        locationCollectionView = collectionView
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
        
    func applyInitialSnapshots(with address: [Address]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Address>()
        snapshot.appendSections([.main])
        snapshot.appendItems(address)
        dataSource?.apply(snapshot)
    }
}






