//
//  Endpoints.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol EndpointProtocol {
    var apiToken: String {get}
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

//MARK: - Endpoints

enum Endpoint {
    case search(searchWord: String, year: String?, type: FilterType)
    case titleSearch(title: String, year: String?, type: FilterType)
    case idSearch(title: String)
}

extension Endpoint: EndpointProtocol {
    var apiToken: String {
        return "f46c0017"
    }

    var baseURL: String {
        return "https://www.omdbapi.com"
    }

    var path: String {
        switch self {
            case .search, .titleSearch, .idSearch: return "/"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }

    var parameters: [String : Any]? {
        return nil
    }

    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("URL ERROR")
        }

        //Add QueryItem
        let urlqueryItemOfApiKey = URLQueryItem(name: "apikey", value: apiToken)

        if case .titleSearch(let title, let year, let type) = self {

            components.queryItems = [urlqueryItemOfApiKey,
                                     URLQueryItem(name: "t", value: title),
                                     URLQueryItem(name: "y", value: String(describing: year)),
                                     URLQueryItem(name: "type", value: type.value)
            ]
        }

        if case .idSearch(let title) = self {
            components.queryItems = [urlqueryItemOfApiKey,
                                     URLQueryItem(name: "i", value: title)
            ]
        }

        if case .search(let searchWord, let year, let type) = self {
            components.queryItems = [urlqueryItemOfApiKey,
                                     URLQueryItem(name: "s", value: searchWord),
                                     URLQueryItem(name: "y", value: String(describing: year)),
                                     URLQueryItem(name: "type", value: type.value)
            ]
        }


        //Add Path
        components.path = path

        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        //Add Paramters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }

        //Add Header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
}
