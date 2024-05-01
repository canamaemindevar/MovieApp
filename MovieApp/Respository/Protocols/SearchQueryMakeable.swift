//
//  SearchQueryMakeable.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MCore
import MNetwork

protocol SearchQueryMakeable: AnyObject {
    func makeSearchQuery(word: String, year: String?, type: String?, completion: @escaping (Result< SearchResponse, ErrorTypes>) -> Void)
}
