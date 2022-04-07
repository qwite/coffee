import Foundation

typealias CoffeeModel = Coffee

struct Coffee {
    let id: Int
    let title: String
    let description: String
    let image: String
    let price: Int
    let quantity: Int?
    let size: String?
    
    init(id: Int, title: String, description: String, image: String, price: Int, quantity: Int? = 1,
         size: String? = "S") {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.price = price
        self.quantity = quantity
        self.size = size
    }
}
