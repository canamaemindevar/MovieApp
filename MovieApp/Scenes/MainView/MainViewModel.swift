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
    var filterModel: SearchOptions {get set}
    func makeQuery(withWord: String)
}

final class MainViewModel: MainViewModelInterface {

    private weak var view: MainViewInterface?
    private var manager: (IdAndTitleQueryMakeable & SearchQueryMakeable)?

    var filterModel: SearchOptions = .init(option: .generalSearch,selectedSecond: .all)
    var pageData: [ListSection]? = []
    private let mockResponse: ListSection = {
        .titleAndIdResponse([.init(title: nil, year: nil, rated: nil, released: nil, runtime: nil, genre: nil, director: nil, writer: nil, actors: nil, plot: nil, language: nil, country: nil, awards: nil, poster: nil, metascore: nil, imdbRating: nil, imdbVotes: nil, imdbID: nil, type: nil, response: nil, ratings: nil)])
    }()
    private let lastSearch: ListSection = {
        .lastSearchs([.init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil),
                      .init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil)])
    }()

    init(view: MainViewInterface, manager: NetworkManager) {
        self.view = view
        self.manager = manager
    }
    func viewDidLoad() {
        view?.prepare()
        makeQuery(withWord: "Batman")
        self.pageData = [.titleAndIdResponse(mockResponse.items), .lastSearchs(lastSearch.items)]
    }

    func makeQuery(withWord: String) {
        switch filterModel.option {
            case .generalSearch:
                switch filterModel.selectedSecond?.value {
                    case "All":
                        manager?.makeSearchQuery(word: withWord, year: nil, type: nil, completion: { response in
                            self.handleSearchResponse(response: response)
                        })
                    case "Type":
                        if let option = filterModel.thirdOption  {

                            if option == "All" {
                                manager?.makeSearchQuery(word: withWord, year: nil, type: nil, completion: { response in
                                    self.handleSearchResponse(response: response)
                                })
                            } else {
                                manager?.makeSearchQuery(word: withWord, year: nil, type: filterModel.thirdOption, completion: { response in
                                    self.handleSearchResponse(response: response)
                                })
                            }
                        }
                    case "Year":
                        manager?.makeSearchQuery(word: withWord, year: filterModel.thirdOption, type: nil, completion: { response in
                            self.handleSearchResponse(response: response)
                        })
                    case .none:
                        Logger.shared.log(text: "general -none- çalıştı ")
                    case .some(_):
                        Logger.shared.log(text: "general -some- çalıştı ")
                }
            case .title:
                manager?.makeQueryWithTitle(title: withWord, completion: { response in
                    self.handleResponse(response: response)
                })
            case .id:
                manager?.makeQueryWithID(id: withWord, completion: { response in
                    self.handleResponse(response: response)
                })
        }
    }

}
//MARK: - Handle Functions
extension MainViewModel {

    private func handleResponse(response:Result<TitleQueryResponse,ErrosTypes>) {
        switch response {
            case .success(let success):
                if success.response == "True" {
                    let array = Array(repeating: success, count: 1)
                    self.handleTitleQueryResponse(response: .success(array))
                } else {
                    handleEmptyData()
                }

            case .failure:
                handleEmptyData()
        }
    }

    private func handleTitleQueryResponse(response:Result<[TitleQueryResponse],ErrosTypes>) {
        switch response {
            case .success(let success):
                let data: [TitleQueryResponse] = success
                self.pageData = [.titleAndIdResponse(data), .lastSearchs(lastSearch.items)]
                view?.reloadCollectionView()
            case .failure:
                handleEmptyData()
        }
    }

    private func handleSearchResponse(response:Result<SearchResponse,ErrosTypes>) {
        switch response {
            case .success(let success):
                if success.response == "True" {
                    if let searchResults = success.search {
                        let value =  searchResults.map { element in
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
                        }
                        handleTitleQueryResponse(response: .success(value))
                    }

                } else {
                    handleEmptyData()
                }

            case .failure:
                handleEmptyData()
        }
    }

    private func handleEmptyData() {
        self.pageData = []
        view?.reloadCollectionView()
        view?.presentEmptyDataAlert()
    }

}
