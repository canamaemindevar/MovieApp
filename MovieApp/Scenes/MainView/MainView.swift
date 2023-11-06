//
//  MainView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

protocol MainViewInterface: AnyObject {
    func prepare()
}

final class MainView: UIViewController {
    
    private lazy var viewModel = MainViewModel(view: self)

    //MARK: - Components

    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()

    }
    
}

//MARK: - MainViewViewInterface

extension MainView: MainViewInterface { 

  func prepare() { 
    
  }

}