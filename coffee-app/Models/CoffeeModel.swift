import Foundation

struct Coffee {
    let title: String
    let description: String
    let image: String
    let price: Int
    
    init(title: String, description: String, image: String, price: Int) {
        self.title = title
        self.description = description
        self.image = image
        self.price = price
    }
}
