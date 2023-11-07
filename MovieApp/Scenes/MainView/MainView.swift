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
    var navVc = UINavigationController()
    //MARK: - Components

    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()
        presentPremiumView()

    }
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

//MARK: - MainViewViewInterface

extension MainView: MainViewInterface { 

  func prepare() { 
    
  }

}
extension MainView :QueryFiltersMakeble {
    func makeQueryFilter(model: SearchOptions) {
        dump(model)
    }
}
