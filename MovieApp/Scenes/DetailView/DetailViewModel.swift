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

    init(view: DetailViewInterface) {
        self.view = view
    }
    func viewDidLoad() {
        view?.prepare()
    }
    
}
