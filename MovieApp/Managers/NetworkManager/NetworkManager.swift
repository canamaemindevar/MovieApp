//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol IdAndTitleQueryMakeable: AnyObject {
    func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrosTypes>) -> Void)
    func makeQueryWithTitle(title: String, completion: @escaping (Result< TitleQueryResponse, ErrosTypes>) -> Void)
}

protocol SearchQueryMakeable: AnyObject {
    func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result< SearchResponse, ErrosTypes>) -> Void)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager: IdAndTitleQueryMakeable {
    func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrosTypes>) -> Void) {
        let endPoint = Endpoint.idSearch(id: id)
        CoreNetworkManager.shared.request(endPoint, completion: completion)
    }

    func makeQueryWithTitle(title: String, completion: @escaping (Result< TitleQueryResponse, ErrosTypes>) -> Void) {
        let endPoint = Endpoint.titleSearch(title: title)
        CoreNetworkManager.shared.request(endPoint, completion: completion)
    }
}

extension NetworkManager: SearchQueryMakeable {

    func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result<SearchResponse, ErrosTypes>) -> Void) {
        let endPoint = Endpoint.search(searchWord: word, year: year, type: type)
        CoreNetworkManager.shared.request(endPoint, completion: completion)
    }
}
