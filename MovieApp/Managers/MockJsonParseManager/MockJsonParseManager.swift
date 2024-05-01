//
//  MockJsonParseManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 1.05.2024.
//

import Foundation
import MNetwork

final class MockJsonParseManager {
    func parseResponse<T: Decodable>(jsonData: Data, completion: @escaping (Result<T, ErrorTypes>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: jsonData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.parsingError))
        }
    }
}
