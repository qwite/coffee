import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class Networking {
    static let sharedInstance = Networking()
    
    func loginRequest(phone: String, password: String, completion: @escaping (String?, AFError?) -> Void) {
        let loginData = Login(phone_number: phone, password: password)
        
        AF.request("http://127.0.0.1:8000/api/auth/token/login/",
                   method: .post,
                   parameters: loginData).responseDecodable(of: Token.self) { response in
            guard let token = response.value else {
                return completion(nil, response.error)
            }
            
            completion(token.auth_token, nil)
        }
    }
    
    func registerRequest(name: String, phone: String, password: String, completion: @escaping (String?, AFError?) -> Void) {
        let registerData = Register(first_name: name, phone_number: phone, password: password, id: nil)
        
        AF.request("http://localhost:8000/api/auth/users/",
                   method: .post, parameters: registerData).responseDecodable(of: Register.self) { response in
            guard let resp = response.value else {
                return completion(nil, response.error)
            }

            completion(resp.first_name, nil)
        }
    }
    
    func getLocations (completion: @escaping ([Address]?, AFError?) -> Void ) -> Void {
        var locations: [Address] = []
        AF.request("http://localhost:8000/api/cafe/", method: .get).responseDecodable(of: [Cafe].self) { response in
          
            guard let response = response.value else {
                return completion(nil, response.error)
            }
            
            response.forEach { cafe in
                locations.append(Address(title: cafe.address!, absolute_url: cafe.get_absolute_url!))
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
                coffeeArray.append(CoffeeModel(title: coffee.name!,
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
}

extension Networking {
    struct Login: Encodable {
        let phone_number: String
        let password: String
    }
    
    struct Register: Encodable, Decodable {
        let first_name: String?
        let phone_number: String?
        let password: String?
        let id: Int?
        
        init(first_name: String, phone_number: String, password: String, id: Int?) {
            self.first_name = first_name
            self.phone_number = phone_number
            self.password = password
            self.id = id
        }
    }
    
    struct Token: Decodable {
        let auth_token: String
    }
    
    private struct Cafe: Decodable {
        let id: Int
        let address: String?
        let coffee: [Coffee]?
        let orders: [Order]?
        let get_absolute_url: String?
    }
    
    private struct Coffee: Decodable {
        let id: Int?
        let name, description: String?
        let price, cafe: Int?
        let get_absolute_url: String?
        let image: String?
        let thumbnail: String?
    }
    struct Order: Codable {
        let id, user, cafe: Int
        let items: [Item]
        let get_total_cost: Int
        let created: String
        let is_paid: Bool
    }
    
    struct Item: Codable {
        let id, order, coffee: Int
        let size: String
        let quantity, get_cost: Int
        let added: String
    }
}
