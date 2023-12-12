//
//  CoreNetworkManager.swift
//  MovieApp
//
//  Created by Emincan Antalyalı on 6.11.2023.
//

import Foundation

protocol CoreNetworkManagerInterface {
    func request<T: Codable>(_ endpoint: Endpoint,completion: @escaping((Result<T,ErrosTypes>)->()))
}

class CoreNetworkManager: CoreNetworkManagerInterface {

    static let shared = CoreNetworkManager()
    private init() {}

    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, ErrosTypes>) -> Void) {

        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in

            if error != nil {
                Logger.shared.log(text: ErrosTypes.generalError.rawValue)
                completion(.failure(.generalError))
                return
            }

            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {

                completion(.failure(.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            self.handleResponse(data: data) { response in
                completion(response)
            }
        }
        task.resume()
    }

    //MARK:  Handle func

    fileprivate func handleResponse<T: Codable>(data: Data, compeltion: @escaping( (Result<T,ErrosTypes>)-> () ) ) {

        do {
            let succesData =  try JSONDecoder().decode(T.self, from: data)
            compeltion(.success(succesData))
        } catch  {
            Logger.shared.log(text: String(describing: error))
            compeltion(.failure(.parsingError))
        }

    }
}

