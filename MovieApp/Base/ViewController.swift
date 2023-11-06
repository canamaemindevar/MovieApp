//
//  ViewController.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        NetworkManager.shared.makeQueryWithID(title: "tt1285016") { res in
//            switch res {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    print(failure)
//            }
//        }
//        NetworkManager.shared.makeSearchQuery(word: "lucy", year: nil, type: .all) { res in
//            switch res {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    print(failure)
//            }
//        }
        showPickerForFilter()
    }

    func showPickerForFilter() {
        view.backgroundColor = .green
        let vc = SearchOptionsViewController()
        vc.delegate = self
        let navVc = UINavigationController(rootViewController: vc)
       // navVc.isModalInPresentation = true
        if let sheet = navVc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        navigationController?.present(navVc,animated: true)

    }

}

extension ViewController :QueryFiltersMakeble {
    func makeQueryFilter() {
        print("works")
    }


}

