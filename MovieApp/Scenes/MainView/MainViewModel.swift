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
    var filterModel: SearchOptions = .init(option: .generalSearch)

    func makeQuery(withWord: String) {
        dump(filterModel)
        switch filterModel.option {
            case .generalSearch:
                switch filterModel.selectedSecond?.value {

                    case "All":
                        print("general -all- çalıştı ")
                    case "Type":
                        if let option = filterModel.thirdOption  {
                            print("general -type- \(option)-çalıştı ")
                            if option == "All" {
                             //req without paremetre
                            } else {
                            // req with parametre
                            }
                        }
                        print("general -type- çalıştı ")
                    case "Year":
                        print("general -year- çalıştı ")
                    case .none:
                        Logger.shared.log(text: "general -none- çalıştı ")
                    case .some(_):
                        Logger.shared.log(text: "general -some- çalıştı ")
                }
            case .title:
                print("title- çalıştı ")
            case .id:
                print("id- çalıştı ")
        }
    }


    var pageData: [ListSection]? {
        didSet {
            view?.reloadCollectionView()
        }
    }
    private weak var view: MainViewInterface?

    init(view: MainViewInterface) {
        self.view = view
    }
    func viewDidLoad() {
        view?.prepare()
        pageData = [results, lastSearch]
        self.pageData = [.titleAndIdResponse(results.items),.searchResponse(lastSearch.items)]
    }

    private let results: ListSection = {
        .titleAndIdResponse([
            .init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil),
            .init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil),
            .init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil)])
    }()

    private let lastSearch: ListSection = {
        .searchResponse([.init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", response: "", ratings: nil)])
    }()


}
//MARK: - Handle Functions
extension MainViewModel {

    private func handleTitleQueryResponse(response:Result<[TitleQueryResponse],ErrosTypes>) {
        switch response {
            case .success(let success):
                print(success)
                //let data: [TitleQueryResponse] = [success]
                self.pageData = [.titleAndIdResponse(success),.searchResponse(lastSearch.items)]
            case .failure(let failure):
                print(failure)
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

                }
            case .failure(let failure):
                print(failure)
        }
    }
}
