//
//  UserDefaultManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 8.11.2023.
//

import Foundation

struct UserDefaultManager {
    static let shared = UserDefaultManager()

    private let userDefaults = UserDefaults.standard
    private let key = "TitleQueryResponseArray"

    func saveData(_ data: [TitleQueryResponse]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            Logger.shared.log(text: "Error while encoding data: \(error)")
        }
    }

    func fetchData() -> [TitleQueryResponse] {
        guard let savedData = userDefaults.data(forKey: key) else { return [] }

        do {
            let decodedData = try JSONDecoder().decode([TitleQueryResponse].self, from: savedData)
            return decodedData
        } catch {
            Logger.shared.log(text: "Error while encoding data: \(error)")
            return []
        }
    }

    func updateDataWithUniqueID(_ success: TitleQueryResponse) {
        var retrievedData = fetchData()
        if let index = retrievedData.firstIndex(where: { $0.imdbID == success.imdbID }) {
            retrievedData.remove(at: index)
        }
        retrievedData.insert(success, at: 0)
        saveData(retrievedData)
    }
}
