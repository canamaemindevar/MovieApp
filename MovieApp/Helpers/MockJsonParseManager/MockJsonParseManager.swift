//
//  MockJsonParseManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MNetwork

final class MockJsonParseManager {
    static func parse<T: Decodable>(_ jsonString: String, model: T.Type) -> T? {

        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
