import UIKit

class LocationViewController: UIViewController {

    private var locationCollectionView = LocationCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
    }
    func setupViews() {
        view.addSubview(locationCollectionView)
        locationCollectionView.frame = view.frame
    }
    
}
