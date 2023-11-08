//
//  MockNetworkManager.swift
//  MovieAppTests
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import XCTest
@testable import MovieApp

final class MockNetworkManager: IdAndTitleQueryMakeable, SearchQueryMakeable {

    func createResponseWithCount() -> TitleQueryResponse {
        return .init(title: "Film", year: "2023", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "True", ratings: [.init(source: "", value: "")])
    }

    func createQueryResponse() -> SearchResponse {
        return  SearchResponse(search: [.init(title: "SearchResponse", year: "2000", imdbID: nil, type: nil, poster: nil)], totalResults: "", response: "True")
    }
    

    var shouldReturnSuccess: Bool = true

    func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrosTypes>) -> Void) {
        if shouldReturnSuccess {
            completion(.success(createResponseWithCount()))
        } else {
            completion(.failure(.generalError))
        }
    }

    func makeQueryWithTitle(title: String, completion: @escaping (Result<TitleQueryResponse, ErrosTypes>) -> Void) {
        if shouldReturnSuccess {
            completion(.success(createResponseWithCount()))
        } else {
            completion(.failure(.generalError))
        }
    }

    func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result<SearchResponse, ErrosTypes>) -> Void) {
        if shouldReturnSuccess {
            completion(.success(createQueryResponse()))
        } else {
            completion(.failure(.generalError))
        }
    }
    
}
