//
//  SectionHeader.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import UIKit

final class SectionHeader: UICollectionReusableView {

    static let identifier = "SectionHeader"

    private let label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textLabelColor
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {

        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            self.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }

    func configure(text: String) {
        label.text = text
        self.layer.cornerRadius = 20
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
