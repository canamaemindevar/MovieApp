//
//  SearchOptions.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import Foundation

struct SearchOptions {
    var option: SearchTypes
    var filters: [SecondOptionStuct]?
    var selectedSecond: SecondOptions?
    var thirdOption: String?
}

struct SecondOptionStuct {
    var secondOption: SecondOptions
}
