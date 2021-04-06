//
//  NetworkManager.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 4/5/21.
//

import Foundation

final class NetworkManager {
    
    private let domainURLString = "https://api.themoviedb.org/3/"
    
    func fetchNowPlayingFilms(){
        guard let url = URL(string: domainURLString + "movie/now_playing?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            // HANDLE ERROR
            if let error = error {
                print("Error occurred fetching Now Playing films: \(error)")
                return
            }
            
            // HANDLE RESPONSE
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data {
                let nowPlayingResponse = try? JSONDecoder().decode(NowPlayingResponse.self, from: data)
                
                DispatchQueue.main.async {
                    for item in nowPlayingResponse!.results{
                        print(item.original_title)
                    }
                }
            }
        })
        task.resume()
        
        
    }
}
