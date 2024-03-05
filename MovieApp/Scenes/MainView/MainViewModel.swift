//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation
import MNetwork
protocol MainViewModelInterface {
    func viewDidLoad()
    var filterModel: SearchOptions { get set}
    func makeQuery(withWord: String)
    func handleSearchResponse(response:Result<SearchResponse,ErrosTypes>)
    func handleTitleQueryResponse(response:Result<[TitleQueryResponse],ErrosTypes>)
    func handleResponse(response:Result<TitleQueryResponse,ErrosTypes>)
    var searchData: [TitleQueryResponse] { get set}
    var lastSearchData:[TitleQueryResponse] { get set}
    func viewWillAppear()
}

final class MainViewModel: MainViewModelInterface {

    private weak var view: MainViewInterface?
    private var manager: (IdAndTitleQueryMakeable & SearchQueryMakeable)?

    var filterModel: SearchOptions = .init(option: .generalSearch,selectedSecond: .all)
    var searchData = [TitleQueryResponse]()
    var lastSearchData = [TitleQueryResponse]()
    var enterCount = 0
    init(view: MainViewInterface, manager: (IdAndTitleQueryMakeable & SearchQueryMakeable)?) {
        self.view = view
        self.manager = manager
    }
    func viewDidLoad() {
        view?.prepare()
        makeQuery(withWord: "Batman")
        self.lastSearchData = [.mockData, .mockData]
    }

    func viewWillAppear() {
        let retrievedData = UserDefaultManager.shared.fetchData()
        self.lastSearchData = retrievedData
        view?.reloadCollectionView()
    }

    func makeQuery(withWord: String) {
        switch filterModel.option {
            case .generalSearch:
                switch filterModel.selectedSecond?.value {
                    case K.all.rawValue:
                        manager?.makeSearchQuery(word: withWord, year: nil,
                                                 type: nil, completion: { [weak self] response in
                            self?.handleSearchResponse(response: response)
                        })
                    case K.type.rawValue:
                        guard let option = filterModel.thirdOption  else { return }

                        if option == K.all.rawValue {
                            manager?.makeSearchQuery(word: withWord, year: nil,
                                                     type: nil, completion: { [weak self] response in
                                self?.handleSearchResponse(response: response)
                            })
                        } else {
                            manager?.makeSearchQuery(word: withWord, year: nil,
                                                     type: filterModel.thirdOption,
                                                     completion: {[weak self] response in
                                self?.handleSearchResponse(response: response)
                            })
                        }

                    case K.year.rawValue:
                        manager?.makeSearchQuery(word: withWord, year: filterModel.thirdOption,
                                                 type: nil, completion: { [weak self] response in
                            self?.handleSearchResponse(response: response)
                        })
                    case .none:
                        Logger.shared.log(text: "general -none-")
                    case .some(_):
                        Logger.shared.log(text: "general -some-")
                }
            case .title:
                manager?.makeQueryWithTitle(title: withWord, completion: { [weak self] response in
                    self?.handleResponse(response: response)
                })
            case .id:
                manager?.makeQueryWithID(id: withWord, completion: { [weak self] response in
                    self?.handleResponse(response: response)
                })
        }
    }
}
//MARK: - Handle Functions
extension MainViewModel {
    func handleResponse(response:Result<TitleQueryResponse,ErrosTypes>) {
        switch response {
            case .success(let success):
                if success.response == K.trueValid.rawValue {
                    let array = Array(repeating: success, count: 1)
                    self.handleTitleQueryResponse(response: .success(array))
                } else {
                    handleEmptyData()
                }
            case .failure:
                handleEmptyData()
        }
    }

    func handleTitleQueryResponse(response:Result<[TitleQueryResponse],ErrosTypes>) {
        switch response {
            case .success(let success):
                let data: [TitleQueryResponse] = success
                self.searchData = data
                view?.reloadCollectionView()
            case .failure:
                handleEmptyData()
        }
    }

    func handleSearchResponse(response:Result<SearchResponse,ErrosTypes>) {
        switch response {
            case .success(let success):
                if success.response == K.trueValid.rawValue {
                    if let searchResults = success.search {
                        let value =  searchResults.map { element in
                                TitleQueryResponse(title: element.title,
                                               year: element.year,
                                               poster: element.poster,
                                               imdbID: element.imdbID,
                                               type: element.type)
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
        enterCount += 1
        self.searchData = []
        view?.reloadCollectionView()
        view?.presentEmptyDataAlert()
    }

}
