import Foundation

struct Address: Hashable {
    let id: Int
    let title: String
    let absoluteUrl: String
    
    init(id: Int, title: String, absoluteUrl: String) {
        self.id = id
        self.title = title
        self.absoluteUrl = absoluteUrl
    }
}
