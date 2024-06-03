//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MCore
import MNetwork

final class NetworkManagerImpl {
    let manager = CoreNetworkManager()
    init() {}
}

extension NetworkManagerImpl: IdAndTitleQueryMakeable {
    public func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrorTypes>) -> Void) {
        let endPoint = Endpoint.idSearch(id: id)
        manager.request(endPoint, completion: completion)
    }

    public func makeQueryWithTitle(title: String, completion: @escaping (Result< TitleQueryResponse, ErrorTypes>) -> Void) {
        let endPoint = Endpoint.titleSearch(title: title)
        manager.request(endPoint, completion: completion)
    }
}

extension NetworkManagerImpl: SearchQueryMakeable {

    public func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result<SearchResponse, ErrorTypes>) -> Void) {
        let endPoint = Endpoint.search(searchWord: word, year: year, type: type)
        manager.request(endPoint, completion: completion)
    }
}
