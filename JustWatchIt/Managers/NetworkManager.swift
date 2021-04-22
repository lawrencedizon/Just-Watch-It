import Foundation
import UIKit

/// This class manages  the API network calls to the TMDB API
final class NetworkManager {
    //MARK: - Properties
    var fetchedMovies = [Movie]()
    private let domainURLString = "https://api.themoviedb.org/3/"

    // MARK: - API Calling Functions
    func fetchMovies(type: ListTypes){
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
        }

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
            if let data = data {
                let nowPlayingResponse = try? JSONDecoder().decode(NowPlayingResponse.self, from: data)
                for item in nowPlayingResponse!.results{
                    if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500//\(item.poster_path)"){
                        let image = try? Data(contentsOf: imageURL)
                        guard let imageData = image else { return }
                        self?.fetchedMovies.append(Movie(title: item.original_title,thumbnail: UIImage(data: imageData)))
                    }
                }
            }
        })
        task.resume()
    }
}
