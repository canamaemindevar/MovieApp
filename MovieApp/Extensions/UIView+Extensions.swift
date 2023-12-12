//
//  UIView+Extensions.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import UIKit

extension UIViewController {
    func presentAlert(message: String) {
        let alertVC = CustomAlertViewController(message: message)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
