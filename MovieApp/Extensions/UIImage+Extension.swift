//
//  UIImage+Extension.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import UIKit

extension UIImage {
    static var lockedImage: UIImage {
        return UIImage(named: "locked.png") ?? .actions
    }
}
