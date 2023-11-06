//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol MainViewModelInterface {
    func viewDidLoad()
}

final class MainViewModel: MainViewModelInterface {
    
    private weak var view: MainViewInterface?

    init(view: MainViewInterface) {
        self.view = view
    }
    func viewDidLoad() {
        view?.prepare()
    }
    
}
