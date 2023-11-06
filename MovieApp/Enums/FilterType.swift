//
//  FilterType.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

enum FilterType {
    case movies
    case series
    case episode
    case all

    var value: String? {
        switch self {
            case .movies:
                return  "movies"
            case .series:
                return  "series"
            case .episode:
                return "episode"
            case .all:
                return  nil
        }
    }
}
