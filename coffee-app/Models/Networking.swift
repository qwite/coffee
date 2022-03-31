import Foundation
import Alamofire
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
}
