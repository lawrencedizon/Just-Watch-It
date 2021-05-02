import Foundation
import UIKit

struct NowPlayingResponse: Codable{
    let results: [NowPlayingItem]
    let totalResults: Int?
}

struct NowPlayingItem: Codable{
    let original_title: String
    let poster_path: String
    let release_date: String
}

struct Movie {
    let title: String
    let posterImage: UIImage?
    let year: String
     
    init(title: String, posterImage: UIImage? = nil, year: String){
        self.title = title
        self.posterImage = posterImage
        self.year = year
    }
}
