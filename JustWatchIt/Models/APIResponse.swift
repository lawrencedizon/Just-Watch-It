import Foundation
import UIKit

struct NowPlayingResponse: Codable{
    let results: [NowPlayingItem]
    let totalResults: Int?
}

struct NowPlayingItem: Codable{
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let release_date: String?
}

struct Movie {
    let title: String
    let storyLine: String
    let posterImage: String
    let backDropImage: String
    let year: String
     
    init(title: String, posterImage: String, backDropImage: String, year: String, storyLine: String){
        self.title = title
        self.posterImage = posterImage
        self.backDropImage = backDropImage
        self.year = year
        self.storyLine = storyLine
    }
}
