//
//  DetailView.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
    func prepare()
    var  id: String? {get set}
    var data: TitleQueryResponse? {get set}
}

final class DetailView: UIViewController {
    
    private lazy var viewModel = DetailViewModel(view: self)
    var id: String?
    var data: TitleQueryResponse? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.setImage(self.data?.poster)
                self.nameLabel.text = self.data?.title
                self.yearLabel.text = self.data?.year
                self.actorsLabel.text = self.data?.actors
                self.countryLabel.text = self.data?.country
                self.directorLabel.text = self.data?.director
                self.ratingLabel.text = self.data?.imdbRating
            }
        }
    }
    //MARK: - Components
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "componentBackground")
        // componentBackground
        view.layer.cornerRadius = 60
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "componentBackground")
        view.layer.cornerRadius = 60
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.image = UIImage(named: "locked.png")
        iv.tintColor = .label
        return iv
    }()

    private let nameLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = UIColor(named: "textLabelColor")
        sView.textAlignment = .center
        return sView
    }()


    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillProportionally
        return sView
    }()

    private let yearLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.text = "sdasdasd"
        sView.textColor = UIColor(named: "textLabelColor")
        sView.textAlignment = .center
        return sView
    }()
    private let actorsLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.text = "sdasdasd"
        sView.textAlignment = .left
        sView.numberOfLines = 0
        sView.textColor = UIColor(named: "textLabelColor")
        return sView
    }()
    private let countryLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = UIColor(named: "textLabelColor")
        sView.text = "sdasdasd"
        sView.textAlignment = .left
        return sView
    }()
    private let directorLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = UIColor(named: "textLabelColor")
        sView.text = "sdasdasd"
        sView.textAlignment = .left
        return sView
    }()
    private let ratingLabel: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.textColor = UIColor(named: "textLabelColor")
        sView.text = "sdasdasd"
        sView.textAlignment = .left
        return sView
    }()
    //MARK: - Life Cycle

    override func viewDidLoad() {
        viewModel.viewDidLoad()
        super.viewDidLoad()
    }

}

//MARK: - DetailViewViewInterface

extension DetailView: DetailViewInterface {


  func prepare() { 
      view.backgroundColor = UIColor(named: "backgroundColor")
      let headerviewHeight = view.frame.height / 4


      view.addSubview(headerView)
      view.addSubview(nameLabel)
      view.addSubview(footerView)
      view.addSubview(imageView)
      footerView.addSubview(stackview)
      stackview.addArrangedSubview(yearLabel)
      stackview.addArrangedSubview(actorsLabel)
      stackview.addArrangedSubview(countryLabel)
      stackview.addArrangedSubview(directorLabel)
      stackview.addArrangedSubview(ratingLabel)

      imageView.layer.cornerRadius = (headerviewHeight - 20) / 2

      NSLayoutConstraint.activate([
        nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
        nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),

        view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 1),
        nameLabel.heightAnchor.constraint(equalToConstant: 40)
      ])

      NSLayoutConstraint.activate([
        headerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        headerView.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 0),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: headerView.trailingAnchor, multiplier: 1),
        headerView.heightAnchor.constraint(equalToConstant: headerviewHeight)
      ])

      NSLayoutConstraint.activate([
        footerView.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 3),
        footerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: footerView.trailingAnchor, multiplier:1),
        view.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 30)

      ])

      NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        imageView.heightAnchor.constraint(equalToConstant: headerviewHeight - 20),
        imageView.widthAnchor.constraint(equalToConstant: headerviewHeight - 20)
      ])


      NSLayoutConstraint.activate([
        stackview.leadingAnchor.constraint(equalToSystemSpacingAfter: footerView.leadingAnchor, multiplier: 10),
        stackview.trailingAnchor.constraint(equalToSystemSpacingAfter: footerView.trailingAnchor, multiplier: 1),
        stackview.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 1),
        stackview.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -20)
      ])

  }

}
