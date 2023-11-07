//
//  UIImageView+Extensions.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import SDWebImage
import UIKit

extension UIImageView {

    func setImage(_ url:String?) {

        guard let urlStr = url else {

            self.image = UIImage(named: "cinema")
            return
        }
        let wrappedUrl = URL(string: urlStr)
        self.sd_setImage(with: wrappedUrl)
    }
}
