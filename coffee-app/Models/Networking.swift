import Foundation
import Alamofire
import SwiftyJSON

class Networking {
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
}

extension Networking {
    struct Login: Encodable {
        let phone_number: String
        let password: String
    }
    
    struct Token: Decodable {
        let auth_token: String
    }
}
