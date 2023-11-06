//
//  DetailView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func prepare()
}

final class DetailView: UIViewController {
    
    private lazy var viewModel = DetailViewModel(view: self)

    //MARK: - Components

    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()

    }
    
}

//MARK: - DetailViewViewInterface

extension DetailView: DetailViewInterface { 

  func prepare() { 
    
  }

}