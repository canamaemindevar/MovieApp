//
//  FilmCell.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import UIKit

final class FilmCollectionViewCell: UICollectionViewCell {
    static let identifier = "FilmCollectionViewCell"

    //MARK: - Varibles
    var item: TitleQueryResponse? {
        didSet {
            nameLabel.text = item?.title
            typeLabel.text = item?.type?.capitalized
            yearLabel.text = item?.year
            imageView.setImage(item?.poster)
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .red
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .orange
        return label
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .orange
        return label
    }()

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = .checkmark
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        return iv
    }()

    private let lockView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = .checkmark
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.image = .lockedImage
        return iv
    }()
    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fillEqually
        return sView
    }()

    //MARK: - Init funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        item = nil
    }
    //MARK: SetConts
    func setConts(){
        addSubview(imageView)
        addSubview(stackview)
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(typeLabel)
        stackview.addArrangedSubview(yearLabel)
        let screen = contentView.frame.size

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: screen.width / 2.5)

        ])
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: imageView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            contentView.trailingAnchor.constraint(equalTo: stackview.trailingAnchor,constant: 8),
            stackview.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
}
