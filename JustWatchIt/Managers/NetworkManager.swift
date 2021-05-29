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
        var fetchURL = ""
        
        switch type {
            case .popular:
                fetchURL = domainURLString + "movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1"
            case .nowPlaying:
                fetchURL = domainURLString + "movie/now_playing?api_key=\(Constants.API_KEY)&language=en-US&page=1"
            case .upcoming:
                fetchURL = domainURLString + "movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1"
            case .topRated:
                fetchURL = domainURLString + "movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1"
            case .search:
                fetchURL = domainURLString + "search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)&page=1"
                
        }
        print("Network call")
        print(fetchURL + "\n")

        guard let url = URL(string: fetchURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler:  { [weak self] (data, response, error) in
            
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
            
            //FIXME: - Data(contentsOf:) has terrible performance because we are now fetching the data synchronously and the operation blocks the main thread.
            if let nowPlayingResponse = try? JSONDecoder().decode(NowPlayingResponse.self, from: data){
                for item in nowPlayingResponse.results{
                    self?.fetchedMovies.append(Movie(title: item.original_title!,posterImage: item.poster_path!, backDropImage: item.backdrop_path!, year: item.release_date!, storyLine: item.overview!))
                }
            
                    
                    
//                    //Decode Poster image
//                    guard let posterPath = item.poster_path,
//                          let posterURL = URL(string: "https://image.tmdb.org/t/p/w500//\(posterPath)"),
//                          let posterImage = try? Data(contentsOf: posterURL)
//                    else {
//                        print("Failed to decode posterImage for \(item.original_title!)")
//                        return
//                    }
//
//                    //Decode BackDrop image
//                    guard let backDropPath = item.backdrop_path,
//                          let backDropURL = URL(string: "https://image.tmdb.org/t/p/w500//\(backDropPath)"),
//                          let backDropImage = try? Data(contentsOf: backDropURL)
//                    else {
//                        print("Failed to decode backDropImage for \(item.original_title!)")
//                        return
//                    }
//
//                    //Add decoded data into our fetchedMovies Array
//
            }else{
                print("Failed to decode nowPlayingResponse")
            }
        })
        
        task.resume()
    }
}

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
