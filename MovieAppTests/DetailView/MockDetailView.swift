//
//  MockDetailView.swift
//  MovieAppTests
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import XCTest
@testable import MovieApp

final class MockDetailView: XCTestCase {

    var viewModel: DetailViewModel!
    var view: DetailView!
    var manager: (IdAndTitleQueryMakeable)!

    override func setUpWithError() throws {
        view = .init()
        manager = MockNetworkManager()
        viewModel = .init(view: view, manager: manager)
    }

    override func tearDownWithError() throws {
        view = nil
        manager = nil
        viewModel = nil
    }

    func test_idQuery() {
        viewModel.query()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.view.data?.title, "Film")
        }

    }
}
