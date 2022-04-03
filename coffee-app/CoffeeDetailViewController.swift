import UIKit

class CoffeeDetailViewController: UIViewController {
    
    private let coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let coffeeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30,
                                       weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18,
                                       weight: .regular)
        
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Размер"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.stepValue = 1
        stepper.maximumValue = 3
        stepper.minimumValue = 1
        
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Small", "Medium", "Large"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    let addToOrderButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Добавить в заказ", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
        countLabel.text = "\(Int(stepper.value))"
        
        setupViews()

    }
    
    
    @objc func popVC () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func stepperValueChanged (_ sender: UIStepper!) {
        
        countLabel.text = "\(Int(sender.value))"
        print(sender.value)

    }
    
    func setupViews () {
        Networking.sharedInstance.getImage(url: self.coffee.image) { image, error in
            guard let image = image else {
                return print("error: \(error!)")
            }
            
            DispatchQueue.main.async {
                self.coffeeImage.image = UIImage(data: image)
                self.titleLabel.text = self.coffee.title
                self.descriptionLabel.text = self.coffee.description
                self.priceLabel.text = "\(self.coffee.price) ₽"
            }
        }

        
        
        view.addSubview(coffeeImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(countLabel)
        view.addSubview(priceLabel)
        view.addSubview(sizeLabel)
        view.addSubview(stepper)
        view.addSubview(segmentControl)
        view.addSubview(addToOrderButton)
        
        let layots: [NSLayoutConstraint] = [
            coffeeImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            coffeeImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            coffeeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            coffeeImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            titleLabel.topAnchor.constraint(equalTo: coffeeImage.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            countLabel.centerXAnchor.constraint(equalTo: stepper.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            stepper.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            stepper.topAnchor.constraint(equalTo: countLabel.topAnchor, constant: 30),
            sizeLabel.centerXAnchor.constraint(equalTo: segmentControl.centerXAnchor),
            sizeLabel.topAnchor.constraint(equalTo: countLabel.topAnchor),
            segmentControl.topAnchor.constraint(equalTo: stepper.topAnchor),
            segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            priceLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 40),
            addToOrderButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addToOrderButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            addToOrderButton.widthAnchor.constraint(equalToConstant: 200),
            addToOrderButton.heightAnchor.constraint(equalToConstant: 42)
        ]
        
        NSLayoutConstraint.activate(layots)
    }
    


}

