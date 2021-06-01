//
//  GenreConverter.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 5/31/21.
//

import Foundation

class GenreConverter {
    static public func getGenreString(genreArray: [Int]) -> String {
        var result = ""
        for index in 0..<genreArray.count {
            switch (genreArray[index]){
            case 28:
                result += "Action"
            case 12:
                result += "Adventure"
            case 16:
                result += "Animation"
            case 35:
                result += "Comedy"
            case 80:
                result += "Crime"
            case 99:
                result += "Documentary"
            case 18:
                result += "Drama"
            case 10751:
                result += "Family"
            case 14:
                result += "Fantasy"
            case 36:
                result += "History"
            case 10402:
                result += "Music"
            case 9648:
                result += "Mystery"
            case 27:
                result += "Horror"
            case 10749:
                result += "Romance"
            case 878:
                result += "Sci-Fi"
            case 10770:
                result += "TVMovie"
            case 53:
                result += "Thriller"
            case 10752:
                result += "War"
            case 37:
                result += "Western"
            default:
                result += ""
            }
            if index < genreArray.count - 1 {
                result += " · "
            }
        }
        return result
    }
    
    static public func getGenreArray(genreString: String) -> [Int] {
        var result: [Int] = []
        let genreStringArray =  genreString.components(separatedBy: " ·")
        
        for index in 0..<genreStringArray.count {
            let trimmedWhiteSpaceGenre = genreStringArray[index].trimmingCharacters(in: .whitespacesAndNewlines)
            switch (trimmedWhiteSpaceGenre){
            case "Action":
                result.append(28)
            case "Adventure":
                result.append(12)
            case "Animation":
                result.append(16)
            case "Comedy":
                result.append(35)
            case "Crime":
                result.append(80)
            case "Documentary":
            result.append(99)
            case "Drama":
                result.append(18)
            case "Family":
                result.append(10751)
            case "Fantasy":
                result.append(14)
            case "History":
                result.append(36)
            case "Music":
                result.append(10402)
            case "Mystery":
                result.append(9648)
            case "Horror":
                result.append(27)
            case "Romance":
                result.append(10749)
            case "Sci-Fi":
                result.append(878)
            case "TVMovie":
                result.append(10770)
            case "Thriller":
                result.append(53)
            case "War":
                result.append(10752)
            case "Western":
                result.append(37)
            default:
                print("Genre \(trimmedWhiteSpaceGenre) doesn't exist")
                return result
            }
        }
        return result
    }
}
