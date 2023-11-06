//
//  SearchTypes.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import Foundation

enum SearchTypes {
    case generalSearch
    case title
    case id

    var value: String {
        switch self {
            case .generalSearch:
                return  "General Search"
            case .title:
                return  "Title"
            case .id:
                return  "Id"
        }
    }
}

enum SecondOptions{
    case year
    case type
    case all
    var value: String {
        switch self {
            case .year:
                return  "Year"
            case .type:
                return  "Type"
            case .all:
                return "All"
        }
    }

    var nextOptionArray: [String] {
        switch self {
            case .year:
                return (2000...2023).map { String($0) }.reversed()
            case .type:
                return  [FilterType.all.value ?? "All",
                         FilterType.episode.value ?? "Episode",
                         FilterType.movies.value ?? "Movies",
                         FilterType.series.value ?? "Series"]
            case .all:
                return []
        }
    }
}
