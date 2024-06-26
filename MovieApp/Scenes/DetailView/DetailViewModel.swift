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
    

    init(view: DetailViewInterface,manager: IdAndTitleQueryMakeable?) {
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
                    if success.response == K.trueValid.rawValue {
                        self.view?.data = success
                        UserDefaultManager.shared.updateDataWithUniqueID(success)
                    }
                case .failure(let failure):
                    print(failure)
            }
        })
    }
    
}
