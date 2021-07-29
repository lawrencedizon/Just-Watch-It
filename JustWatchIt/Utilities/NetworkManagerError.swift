//
//  NetworkManagerError.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 7/29/21.
//

import Foundation

enum NetworkManagerError: LocalizedError {
    case unableToFetch
    case invalidURL
    
    var errorDescription: String? {
        switch self {
            case .unableToFetch:
                return "Failed to fetch content."
            case .invalidURL:
                return "Invalid URL"
        }
    }
}
