//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol MainViewModelInterface {
    func viewDidLoad()
    var pageData: [ListSection]? {get set}
}

final class MainViewModel: MainViewModelInterface {
    var pageData: [ListSection]?

    
    private weak var view: MainViewInterface?

    init(view: MainViewInterface) {
        self.view = view
    }
    func viewDidLoad() {
        view?.prepare()
        pageData = [results, lastSearch]
    }

    private let results: ListSection = {
        .titleAndIdResponse([.init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil)])
    }()

    private let lastSearch: ListSection = {
        .searchResponse([.init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil)])
    }()

}
enum ListSection {
    case titleAndIdResponse([TitleQueryResponse])
    case searchResponse([TitleQueryResponse])

    var items: [TitleQueryResponse] {
        switch self {
            case .titleAndIdResponse(let array):
                return array
            case .searchResponse(let array):
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
            case .searchResponse:
               return "Last Searchs"
        }
    }
}

/*
 return (searchResponse.search?.map({ element in
 TitleQueryResponse(title: element.title,
 year: element.year,
 rated: nil,
 released: nil,
 runtime: nil,
 genre: nil,
 director: nil,
 writer: nil,
 actors: nil,
 plot: nil,
 language: nil,
 country: nil,
 awards: nil,
 poster: element.poster,
 metascore: nil,
 imdbRating: nil,
 imdbVotes: nil,
 imdbID: element.imdbID,
 type: element.type,
 response: nil,
 ratings: nil)
 }) as! [TitleQueryResponse])
 */
