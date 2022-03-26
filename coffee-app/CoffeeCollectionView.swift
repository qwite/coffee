import UIKit



class CoffeeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var coffeeDelegate: CoffeeCollectionViewDelegate?
    
    var coffeeItemsArray: [Coffee] = {
        var latte = Coffee(
            title: "Латте",
            description: "Нежное пропаренное молоко, богатый вкус эспрессо и тонкий слой молочной пены, завершающий напиток.",
            image: "caffelatte",
            price: 330)
        
        var cappuccino = Coffee(
            title: "Капучино",
            description: "Кофейный напиток итальянской кухни на основе эспрессо с добавлением в него подогретого вспененного молока.",
            image: "cappuccino",
            price: 230)
        
        var caramelMacchiato = Coffee(
            title: "Карамельный Маккиато",
            description: "Пропаренное молоко в сочетании с ванильным сиропом и насыщенным эспрессо.",
            image: "caramelmacchiato",
            price: 400)
        
        var espressoMint = Coffee(
            title: "Эспрессо-тоник с мятой",
            description: "Холодный и бодрящий эспрессо-тоник, идеально сочетающий в себе кофе.",
            image: "espressomint",
            price: 300)
        
        return [latte, cappuccino, caramelMacchiato, espressoMint]
    }()
    
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CoffeeCell.self, forCellWithReuseIdentifier: CoffeeCell.reuseId)
        
   
        backgroundColor = .white
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeItemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CoffeeCell.reuseId, for: indexPath) as! CoffeeCell
        
        let coffee = coffeeItemsArray[indexPath.row]
        cell.setup(with: coffee)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 40
        let availableWidth = collectionView.frame.width - padding
        return CGSize(width: availableWidth, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        coffeeDelegate?.pushController(controller: CoffeeDetailViewController(item: coffeeItemsArray[indexPath.row]))
      
    }
    
}
