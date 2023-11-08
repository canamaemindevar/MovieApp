//
//  UIColor+Extension.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import UIKit

extension UIColor {
    static var textLabelColor: UIColor {
        return UIColor(named: "textLabelColor") ?? .black
    }

    static var componentBackground: UIColor {
        return UIColor(named: "componentBackground") ?? .white
    }
    static var backgroundColor: UIColor {
        return UIColor(named: "backgroundColor") ?? .white
    }

}
