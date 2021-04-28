import Foundation
import UIKit

struct NowPlayingResponse: Codable{
    let results: [NowPlayingItem]
    let totalResults: Int?
}

struct NowPlayingItem: Codable{
    let original_title: String
    let poster_path: String
    let backdrop_path: String
    let release_date: String
}

struct Movie {
    let title: String
    let posterImage: UIImage?
    let backDropImage: UIImage?
    let year: String
     
    init(title: String, posterImage: UIImage? = nil, backdropImage: UIImage? = nil, year: String){
        self.title = title
        self.posterImage = posterImage
        self.backDropImage = backdropImage
        self.year = year
    }
}
