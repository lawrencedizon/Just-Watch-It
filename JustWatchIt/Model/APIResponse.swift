import Foundation
import UIKit

struct NowPlayingResponse: Codable{
    let results: [NowPlayingItem]
    let totalResults: Int?
}

struct NowPlayingItem: Codable{
    let original_title: String
    let poster_path: String
}

struct Movie {
    let title: String
    var thumbnail: UIImage?
    let year: Int?
    
    init(title: String, thumbnail: UIImage? = nil, year: Int? = nil){
        self.title = title
        self.thumbnail = thumbnail
        self.year = year
    }
}
