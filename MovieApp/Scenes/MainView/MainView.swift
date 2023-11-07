//
//  MainView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import SwiftUI

protocol MainViewInterface: AnyObject {
    func prepare()
}

final class MainView: UIViewController {
    
    private lazy var viewModel = MainViewModel(view: self)
    private var navVc = UINavigationController()
    private let searchVc = UISearchController(searchResultsController: nil)

    //MARK: - Components

    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()
        prepare()
    }
}

private extension MainView {
    func setupNavigationView() {
        navigationItem.searchController = searchVc
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showFilters))
        let premiumButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showPremium))
        navigationItem.rightBarButtonItems = [searchButton,premiumButton]
    }

    @objc func showFilters() {
        showPickerForFilter()
    }
    @objc func showPremium() {
        presentPremiumView()
    }
}

//MARK: - MainViewViewInterface

extension MainView: MainViewInterface { 

  func prepare() { 
      setupNavigationView()
  }

}
extension MainView :QueryFiltersMakeble {
    func makeQueryFilter(model: SearchOptions) {
        dump(model)
    }
}
//MARK: - Presenting Modals
private extension MainView {

    func showPickerForFilter() {
        view.backgroundColor = .green
        lazy var vc = SearchOptionsViewController()
        vc.delegate = self
        navVc = UINavigationController(rootViewController: vc)
        if let sheet = navVc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController?.present(navVc,animated: true)
    }

    func presentPremiumView() {
        let vc = PremiumView()
        let premiumView = UIHostingController(rootView: vc)
        self.navigationController?.present(premiumView, animated: true)
    }
}
