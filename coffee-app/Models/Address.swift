import Foundation

struct Address: Hashable {
    let title: String
    let absolute_url: String
    
    init(title: String, absolute_url: String) {
        self.title = title
        self.absolute_url = absolute_url
    }
}
