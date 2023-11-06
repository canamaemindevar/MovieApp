//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

final class NetworkManager {

    func makeQuery(completion: @escaping (Result< TitleQueryResponse, ErrosTypes>) -> Void) {
        let endpoitn = Endpoint.titleSearch(title: "Edmond & Lucy", year: "2023", type: .all)
        CoreNetworkManager.shared.request(endpoitn, completion: completion)
    }
}
