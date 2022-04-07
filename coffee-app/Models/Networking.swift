import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class Networking {
    static let sharedInstance = Networking()
    
    private init () {}
    
    func loginRequest(phone: String, password: String, completion: @escaping (String?, AFError?) -> Void) {
        let loginData = Login(phoneNumber: phone, password: password)
        
        AF.request("http://127.0.0.1:8000/api/auth/token/login/",
                   method: .post,
                   parameters: loginData).responseDecodable(of: Token.self) { response in
            guard let token = response.value else {
                return completion(nil, response.error)
            }
            
            completion(token.authToken, nil)
        }
    }
    
    func registerRequest(name: String, phone: String, password: String,
                         completion: @escaping (String?, AFError?) -> Void) {
        let registerData = Register(firstName: name, phoneNumber: phone, password: password, id: nil)
        
        AF.request("http://localhost:8000/api/auth/users/",
                   method: .post, parameters: registerData).responseDecodable(of: Register.self) { response in
            guard let resp = response.value else {
                return completion(nil, response.error)
            }

            completion(resp.firstName, nil)
        }
    }
    
    func getLocations (completion: @escaping ([Address]?, AFError?) -> Void ) {
        var locations: [Address] = []
        AF.request("http://localhost:8000/api/cafe/", method: .get).responseDecodable(of: [Cafe].self) { response in
          
            guard let response = response.value else {
                return completion(nil, response.error)
            }
            
            response.forEach { cafe in
                locations.append(Address(id: cafe.id, title: cafe.address!, absoluteUrl: cafe.getAbsoluteUrl!))
            }
            completion(locations, nil)
        }
    }
    
    func getAvailableCoffee (cafe: String, completion: @escaping ([CoffeeModel]?, AFError?) -> Void) {
        var coffeeArray: [CoffeeModel] = []
        AF.request("http://localhost:8000/api/cafe" + cafe, method: .get).responseDecodable(of: Cafe.self) { response in
            guard let response = response.value?.coffee else {
                return completion(nil, response.error)
            }
            
            response.forEach { coffee in
                coffeeArray.append(CoffeeModel(id: coffee.id!,
                                               title: coffee.name!,
                                               description: coffee.description!,
                                               image: coffee.image!,
                                               price: coffee.price!))
            }
        
            completion(coffeeArray, nil)
        }
    }
    
    func getImage (url: String, completion: @escaping (Data?, AFError?) -> Void) {
        AF.request(url, method: .get).responseImage { response in
            guard let image = response.data else {
                return completion(nil, response.error)
            }
            
            completion(image, nil)
        }
    }
    
    func getUserData(completion: @escaping (User?, AFError?) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)"
        ]
        
        AF.request("http://localhost:8000/api/auth/users/me/", method: .get, headers: headers)
            .responseDecodable(of: User.self) { response in
            completion(response.value, nil)
        }
    }
    
    func createOrder (userId: Int?, locationId: Int?, coffeeId: Int?, size: String?, quantity: Int?,
                      completion: @escaping (Item?, AFError?) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)"
        ]
        
        let cafe = Order(id: nil, user: nil, cafe: locationId,
                         items: nil, getTotalCost: nil, created: nil, isPaid: nil)
        
        AF.request("http://localhost:8000/api/orders/", method: .post, parameters: cafe, headers: headers)
            .responseDecodable(of: Order.self) { response in
            
            guard let order = response.value else {
                return completion(nil, response.error)
            }
            
            let temp = Temp(coffee: coffeeId!, order: order.id!, size: size!, quantity: quantity!)
            
            AF.request("http://localhost:8000/api/order-items/", method: .post, parameters: temp, headers: headers)
                    .responseDecodable(of: Item.self) { finalresp in
                
                guard let result = finalresp.value else {
                    return completion(nil, finalresp.error)
                }
                
                completion(result, nil)
            }
        }
    }
}

extension Networking {
    struct Login: Encodable {
        let phoneNumber: String
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case phoneNumber = "phone_number"
            case password = "password"
        }
    }

    struct Register: Codable {
        let firstName: String?
        let phoneNumber: String?
        let password: String?
        let id: Int?
        
        init(firstName: String, phoneNumber: String, password: String, id: Int?) {
            self.firstName = firstName
            self.phoneNumber = phoneNumber
            self.password = password
            self.id = id
        }
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case phoneNumber = "phone_number"
            case password = "password"
            case id = "id"
        }
    }
    
    struct User: Decodable {
        let firstName: String
        let id: Int
        let phoneNumber: String
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case id = "id"
            case phoneNumber = "phone_number"
        }
    }
    
    struct Token: Decodable {
        let authToken: String
        
        enum CodingKeys: String, CodingKey {
            case authToken = "auth_token"
        }
    }
    
    private struct Cafe: Decodable {
        let id: Int
        let address: String?
        let coffee: [Coffee]?
        let orders: [Order]?
        let getAbsoluteUrl: String?

        enum CodingKeys: String, CodingKey {
            case id
            case address
            case coffee
            case orders
            
            case getAbsoluteUrl = "get_absolute_url"
        }
    }
    
    private struct Coffee: Decodable {
        let id: Int?
        let name, description: String?
        let price, cafe: Int?
        let getAbsoluteUrl: String?
        let image: String?
        let thumbnail: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name, description
            case price, cafe
            
            case getAbsoluteUrl = "get_absolute_url"
            case image
            case thumbnail
        }
    }
    struct Order: Codable {
        let id, user, cafe: Int?
        var items: [Item]?
        let getTotalCost: Int?
        let created: String?
        let isPaid: Bool?
        
        enum CodingKeys: String, CodingKey {
            case id, user, cafe
            case items
            case getTotalCost = "get_total_cost"
            case created
            case isPaid = "is_paid"
        }
        
        init(id: Int?, user: Int?, cafe: Int?, items: [Item]?, getTotalCost: Int?, created: String?, isPaid: Bool?) {
            self.id = id
            self.user = user
            self.cafe = cafe
            self.items = items
            self.getTotalCost = getTotalCost
            self.created = created
            self.isPaid = isPaid
        }
    }
    
    struct Temp: Codable {
        let coffee: Int
        let order: Int
        let size: String
        let quantity: Int
    }
    
    struct Item: Codable {
        let id, order, coffee: Int?
        let size: String?
        let quantity, getCost: Int?
        let added: String?
        
        enum CodingKeys: String, CodingKey {
            case id, order, coffee
            case size
            case quantity
            
            case getCost = "get_cost"
            case added
        }
//        let id, order, coffee: Int?
//        let size: String?
//        let quantity, get_cost: Int?
//        let added: String?
        
        init(order: Int?, coffee: Int?, size: String?, quantity: Int?) {
            self.coffee = coffee
            self.size = size
            self.quantity = quantity
            self.order = order
            self.id = nil
            self.getCost = nil
            self.added = nil
        }
        
        init(id: Int?, order: Int?, coffee: Int?, size: String?, quantity: Int?, getCost: Int?, added: String?) {
            self.id = id
            self.order = order
            self.coffee = coffee
            self.size = size
            self.quantity = quantity
            self.getCost = getCost
            self.added = added
        }
    }
}
