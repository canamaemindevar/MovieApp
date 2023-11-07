//
//  ListSection.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import Foundation

enum ListSection {
    case titleAndIdResponse([TitleQueryResponse])
    case lastSearchs([TitleQueryResponse])

    var items: [TitleQueryResponse] {
        switch self {
            case .titleAndIdResponse(let array):
                return array
            case .lastSearchs(let array):
                return array
        }
    }

    var count: Int {
        return items.count
    }

    var title: String {
        switch self {
            case .titleAndIdResponse:
                return "Results"
            case .lastSearchs:
                return "Last Searchs"
        }
    }
}
