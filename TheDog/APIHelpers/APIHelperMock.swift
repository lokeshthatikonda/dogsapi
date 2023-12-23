//
//  APIHelperMock.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation


class APIHelperMock: ServicesProtocol {
    
    public static var shared = APIHelperMock()
    private init () {}
    
    func requestEndPoint<T:Codable>(endPoint: EndPoint, onCompletion: @escaping (Result<T, Error>) -> Void) {
        let jsonData = readJSON("TheDogBreeds")
        do {
            let codableModel = try JSONDecoder().decode(T.self, from: jsonData)
            onCompletion(.success(codableModel))
        } catch let error {
            onCompletion(.failure(error))
        }
    }
}
