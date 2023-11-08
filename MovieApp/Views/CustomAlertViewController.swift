//
//  CustomAlertViewController.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    let message: String
    private let stackview: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.layer.cornerRadius = 5
        sView.axis = .vertical
        sView.distribution = .fill
        return sView
    }()

    private let imageView: UIImageView = {
        let sView = UIImageView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.contentMode = .scaleAspectFit
        sView.tintColor = .red
        return sView
    }()

    private let label: UILabel = {
        let sView = UILabel()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.textAlignment = .center
        sView.numberOfLines = 0
        sView.backgroundColor = .secondarySystemFill
        return sView
    }()

    private let button: UIButton = {
        let sView = UIButton()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.tintColor = .black
        sView.setTitle("Tamam", for: .normal)
        sView.backgroundColor = .black
        return sView
    }()

    init (message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        imageView.image = UIImage(systemName: "multiply")
        view.addSubview(stackview)
        stackview.addArrangedSubview(imageView)
        stackview.addArrangedSubview(label)
        stackview.addArrangedSubview(button)
        label.text = message
        button.addTarget(self, action: #selector(actionDoneButton), for: .touchUpInside)
        imageView.backgroundColor = .secondarySystemFill
        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackview.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            stackview.widthAnchor.constraint(equalToConstant: view.frame.width / 1.6),

        ])
    }

    @objc private func actionDoneButton(_: UIButton) {
        dismiss(animated: true)
    }
}
