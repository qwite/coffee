import UIKit

class LocationViewController: UIViewController {

    private var locationCollectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<Section, Address>?

    var delegate: CoffeeCollectionViewDelegate?
        
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выберите адрес"
        navigationItem.backButtonTitle = ""
        
        view.backgroundColor = .white
        configureCollectionView()
        applyInitialSnapshots()
        setupViews()
    }
    
    func setupViews() {
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

extension LocationViewController: UICollectionViewDelegate {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
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
        
    func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Address>()
        snapshot.appendSections([.main])
        
        Networking.sharedInstance.getLocations { address, error in
            guard let address = address else {
                return print("error: \(error!)")
            }
            
            DispatchQueue.main.async {
                snapshot.appendItems(address)
                self.dataSource?.apply(snapshot)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Networking.sharedInstance.getLocations { address, error in
            guard let address = address else {
                return print("error: \(error!)")
            }
            
            let selectedAddress = address[indexPath.row]
            UserDefaults.standard.set(selectedAddress.absolute_url, forKey: "defaultLocationUrl")
            UserDefaults.standard.set(selectedAddress.title, forKey: "defaultLocation")
        }
    }
    
}
