//
//  LocalState.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 7.11.2023.
//

import Foundation

public class LocalState {

    private enum Keys: String {
        case isPremium
    }

    public static var hasBought: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isPremium.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isPremium.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
