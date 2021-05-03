import Foundation
import UIKit

/// This class manages  the API network calls to the TMDB API
final class NetworkManager {
    //MARK: - Properties
    var fetchedMovies = [Movie]()
    private let domainURLString = "https://api.themoviedb.org/3/"

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
                fetchURL = domainURLString + "search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)&page=1&include_adult=false"
                
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
                print("We failed to get any data")
                return
            }
            
            if let nowPlayingResponse = try? JSONDecoder().decode(NowPlayingResponse.self, from: data){
                for item in nowPlayingResponse.results{
                    if let posterURL = URL(string: "https://image.tmdb.org/t/p/w500//\(item.poster_path)"), let backDropURL = URL(string: "https://image.tmdb.org/t/p/original//\(item.backdrop_path)"){
                            guard let posterImage = try? Data(contentsOf: posterURL) else {
                                print("posterImage could not be made")
                                return
                            }
                            guard let backDropImage = try? Data(contentsOf: backDropURL) else {
                                print("backDrop image could not be made")
                                return
                            }
                        self?.fetchedMovies.append(Movie(title: item.original_title,posterImage: UIImage(data: posterImage), backDropImage: UIImage(data: backDropImage), year: item.release_date, storyLine: item.overview))
                    }else{
                        print("posterURL failed")
                    }
                }
            }else{
                print("Failed to decode nowPlayingResponse")
            }
        })
        task.resume()
    }
    
    
}
