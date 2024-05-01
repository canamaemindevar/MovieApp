//
//  MockNetworkManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MCore
import MNetwork

final class MockNetworkManager {
    init() {}
}

extension MockNetworkManager: IdAndTitleQueryMakeable{
    func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrorTypes>) -> Void) {

        // mock data response
    }

    func makeQueryWithTitle(title: String, completion: @escaping (Result< TitleQueryResponse, ErrorTypes>) -> Void) {
        // mock data response
    }
}
extension MockNetworkManager: SearchQueryMakeable{
    func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result<SearchResponse, ErrorTypes>) -> Void) {
        // mock data response
        
    }
}

let mockSearchResponseJson: String = """
    {
    "Search": [
        {
            "Title": "The Shawshank Redemption",
            "Year": "1994",
            "imdbID": "tt0111161",
            "Type": "movie",
            "Poster": "https://example.com/posters/shawshank_redemption.jpg"
        },
        {
            "Title": "The Godfather",
            "Year": "1972",
            "imdbID": "tt0068646",
            "Type": "movie",
            "Poster": "https://example.com/posters/godfather.jpg"
        },
        {
            "Title": "The Dark Knight",
            "Year": "2008",
            "imdbID": "tt0468569",
            "Type": "movie",
            "Poster": "https://example.com/posters/dark_knight.jpg"
        }
    ],
    "totalResults": "3",
    "Response": "True"
}
"""

