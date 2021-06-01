struct Constants {
    static let API_KEY = ""
    static let numberOfCollectionViewMovieLists = 4
}

enum ListTypes {
    case popular, nowPlaying, upcoming, topRated, search
}

enum GETMethods {
    static let POPULAR = "movie/popular"
    static let NOWPLAYING = "movie/now_playing"
    static let UPCOMING = "movie/upcoming"
    static let TOPRATED = "movie/top_rated"
    static let SEARCH = "search/movie"
    static let LOWRESIMAGE = "https://image.tmdb.org/t/p/w500//"
    static let HIGHRESIMAGE = "https://image.tmdb.org/t/p/original//"
}
