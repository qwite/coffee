import Foundation

struct Cart {
    static var sharedInstance = Cart()
    
    var items: [Coffee] = []
    private init () {
        
    }
    
    var totalPrice: Int {
        items.reduce(0) { value, item in
            value + item.price * (item.quantity ?? 1)
        }
    }
    
    mutating func add(item: Coffee) {
        items.append(item)
    }
    
//    mutating func remove(id: Int) {
//        items.firstIndex { coffee in
//            coffee.id == id
//        }
//    }
}
