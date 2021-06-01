import Foundation
import UIKit

/// This class manages  the API network calls to the TMDB API
final class NetworkManager {
    //MARK: - Properties
    static let imageCache = NSCache<NSString, UIImage>()
    var fetchedMovies = [Movie]()
    private(set) var domainURLString = "https://api.themoviedb.org/3/"

    // MARK: - API Calling Functions
    func fetchMovies(query: String = "", type: ListTypes){
        var url = ""
        
        switch type {
            case .popular:
                url = "\(domainURLString)\(GETMethods.POPULAR)?api_key=\(Constants.API_KEY)"
            case .nowPlaying:
                url = "\(domainURLString)\(GETMethods.NOWPLAYING)?api_key=\(Constants.API_KEY)"
            case .upcoming:
                url = "\(domainURLString)\(GETMethods.UPCOMING)?api_key=\(Constants.API_KEY)"
            case .topRated:
                url = "\(domainURLString)\(GETMethods.TOPRATED)?api_key=\(Constants.API_KEY)"
            case .search:
                url = "\(domainURLString)\(GETMethods.SEARCH)?api_key=\(Constants.API_KEY)&query=\(query)"
        }
        print("Network call")
        print(url + "\n")

        guard let fetchURL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: fetchURL, completionHandler:  { [weak self] (data, response, error) in
            
            //Error
            if let error = error {
                print("Error occurred fetching movie: \(error)")
                return
            }
            
            //Response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            //Data
            guard let data = data else {
                print("Error with the data, no data was downloaded")
                return
            }
            
            if let nowPlayingResponse = try? JSONDecoder().decode(NowPlayingResponse.self, from: data){
                for item in nowPlayingResponse.results{
                    if let title = item.original_title,
                       let posterPath = item.poster_path,
                       let backDropPath = item.backdrop_path,
                       let year = item.release_date,
                       let story = item.overview {
                        self?.fetchedMovies.append(Movie(title: title,posterImage: posterPath, backDropImage: backDropPath, year: DateConverterHelper.getYear(date: year), storyLine: story, genres: item.genre_ids))
                    }
                }
            }else{
                print("Failed to decode nowPlayingResponse")
            }
        })
        task.resume()
    }
}

//MARK: - Download images and cache Extension
extension UIImageView {
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = NetworkManager.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    NetworkManager.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            }else {
                setImage(image: nil)
            }
        }
    }
}
