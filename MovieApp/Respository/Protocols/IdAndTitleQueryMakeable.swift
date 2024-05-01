//
//  IdAndTitleQueryMakeable.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MCore
import MNetwork

protocol IdAndTitleQueryMakeable: AnyObject {
    func makeQueryWithID(id: String, completion: @escaping (Result<TitleQueryResponse, ErrorTypes>) -> Void)
    func makeQueryWithTitle(title: String, completion: @escaping (Result< TitleQueryResponse, ErrorTypes>) -> Void)
}
