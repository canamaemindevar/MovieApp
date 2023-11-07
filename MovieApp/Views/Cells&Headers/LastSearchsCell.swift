//
//  LastSearchsCell.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//
import UIKit

final class LastSearchsCell: UICollectionViewCell {
    static let identifier = "LastSearchsCell"

    //MARK: - Varibles
    var item: TitleQueryResponse? {
        didSet {
            if LocalState.hasOnboarded == true {
                lockView.setImage(item?.poster)
            }
        }
    }

    private let lockView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = .checkmark
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .label
        iv.image = UIImage(named: "locked.png")
        return iv
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
        let screen = contentView.frame.size
            addSubview(lockView)
            NSLayoutConstraint.activate([
                lockView.centerYAnchor.constraint(equalTo: centerYAnchor),
                lockView.centerXAnchor.constraint(equalTo: centerXAnchor),
                lockView.heightAnchor.constraint(equalToConstant: screen.height - 10),
                lockView.widthAnchor.constraint(equalToConstant: screen.width - 10)
            ])
    }
}
