//
//  MainViewModel.swift
//  MovieAppTests
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import XCTest
@testable import MovieApp

final class MainViewModelTest: XCTestCase {

    var viewModel: MainViewModel!
    var view: MainView!
    var manager: (IdAndTitleQueryMakeable & SearchQueryMakeable)!

    override func setUpWithError() throws {
        view = .init()
        manager = MockNetworkManager()
        viewModel = MainViewModel(view: view, manager: manager! )
    }

    override func tearDownWithError() throws {
        viewModel = nil
        view = nil
        manager = nil
    }

    func test_FilterType() {
        viewModel.filterModel = SearchOptions(option: .title)
        XCTAssertEqual(viewModel.filterModel.option, .title)
    }

    func test_collectionViewDelegateAndDatasourseIsValid() {
        view.loadViewIfNeeded()
        XCTAssertNotNil(view.mainCollectionView.delegate)
        XCTAssertNotNil(view.mainCollectionView.dataSource)
    }

    func test_searchQuery() {
        view.loadViewIfNeeded()
        viewModel.makeQuery(withWord: "")
        XCTAssertEqual(viewModel.searchData.first?.title, "SearchResponse")
    }

    func test_titleQuery() {
        viewModel.filterModel = SearchOptions(option: .title)
        XCTAssertEqual(viewModel.filterModel.option, .title)
        viewModel.makeQuery(withWord: "")
        XCTAssertEqual(viewModel.searchData.first?.title, "Film")
    }
    func test_idQuery() {
        viewModel.filterModel = SearchOptions(option: .id)
        XCTAssertEqual(viewModel.filterModel.option, .id)
        viewModel.makeQuery(withWord: "")
        XCTAssertEqual(viewModel.searchData.first?.title, "Film")
    }
    func test_failQuery() {
        XCTAssertEqual(viewModel.filterModel.option, .generalSearch)
        viewModel.makeQuery(withWord: "")
        XCTAssertEqual(viewModel.enter, 1)
    }
}
