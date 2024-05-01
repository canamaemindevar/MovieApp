//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation
import MNetwork

protocol DetailViewModelInterface {
    func viewDidLoad()
}

final class DetailViewModel: DetailViewModelInterface {
    private weak var view: DetailViewControllerInterface?
    private weak var manager: IdAndTitleQueryMakeable?

    init(view: DetailViewControllerInterface,manager: IdAndTitleQueryMakeable?) {
        self.view = view
        self.manager = manager
    }
    func viewDidLoad() {
        view?.prepare()
        query()
    }

    func query() {
        guard let id = view?.id else {return}
        manager?.makeQueryWithID(id: id, completion: {[weak self] response in
            guard let self = self else {return}
            switch response {
                case .success(let success):
                    guard success.response == K.trueValid.rawValue else { return }
                    self.view?.data = success
                    UserDefaultManager.shared.updateDataWithUniqueID(success)
                case .failure(let failure):
                    Logger.shared.log(text: failure.rawValue)
            }
        })
    }
}
