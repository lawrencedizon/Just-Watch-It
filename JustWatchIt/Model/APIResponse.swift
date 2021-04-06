import Foundation


struct NowPlayingResponse: Codable{
    let results: [NowPlayingItem]
    let totalResults: Int?
}

struct NowPlayingItem: Codable{
    let original_title: String
    let poster_path: String
}
struct Movie: Codable {
    let title: String
    let year: Int
}
