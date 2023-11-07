//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol DetailViewModelInterface {
    func viewDidLoad()
   
}

final class DetailViewModel: DetailViewModelInterface {
    
    private weak var view: DetailViewInterface?
    private weak var manager: IdAndTitleQueryMakeable?
    

    init(view: DetailViewInterface,manager: IdAndTitleQueryMakeable? = NetworkManager.shared) {
        self.view = view
        self.manager = manager
    }
    func viewDidLoad() {
        view?.prepare()
        query()
    }

    func query() {
        guard let id = view?.id else {return}
        manager?.makeQueryWithID(id: id, completion: { response in
            switch response {
                case .success(let success):
                    if success.response == "True" {
                        self.view?.data = success
                    }
                case .failure(let failure):
                    print(failure)
            }
        })
    }
    
}
