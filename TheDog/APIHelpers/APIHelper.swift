//
//  APIHelper.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//
import Foundation
import UIKit

typealias completionHandler = (Bool,Any?) -> Void

protocol ServicesProtocol {
    func requestEndPoint<T: Codable>(endPoint: EndPoint, onCompletion: @escaping (Result<T, Error>) -> Void)
}

class APIHelper: ServicesProtocol {

    public static var shared = APIHelper()
    private let TOPICS_BASE_URL = "https://api.thedogapi.com/v1/"
    private init () { }
    
    func requestEndPoint<T:Codable>(endPoint: EndPoint, onCompletion: @escaping (Result<T, Error>) -> Void) {
        self.get(endPoint: endPoint) { (isSuccess, jsonData) in
            if let error = jsonData as? Error {
                onCompletion(.failure(error))
                return
            }
            if let dataObj = jsonData as? Data{
                do {
                    let codableModel = try JSONDecoder().decode(T.self, from: dataObj)
                    onCompletion(.success(codableModel))
                } catch let error {
                    print(error)
                    onCompletion(.failure(error))
                }
                return
            }
            let error = NSError(domain: "YourAppDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
            onCompletion(.failure(error))
        }
    }
    func get(endPoint:EndPoint, compleationHandler:@escaping completionHandler ) {
        
        var url = URL(string: TOPICS_BASE_URL + (endPoint.path.count > 0 ? endPoint.path : ""))!
        if endPoint.urlParameters.count > 0 {
            let queryItems = endPoint.urlParameters.map {
                return URLQueryItem(name: "\($0)", value: "\($1)")
            }
            var urlComponents = URLComponents(url: url , resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            url = urlComponents?.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.validateResponse(data: data, response: response, error: error) { (isSuccess, jsonData) in
                compleationHandler(isSuccess,jsonData)
            }
        }.resume()
    }
    private func validateResponse(data:Data?, response:URLResponse?, error:Error?, compleationHandler:@escaping completionHandler ) {
        
        if !(response?.isSuccessStausCode ?? false) || error != nil {
            /*if let jsonData = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String:Any] {
             print("Error with JSON \(jsonData)")
             compleationHandler(false,jsonData)
             return
             }*/
            if let err = error {
                compleationHandler(false,err)
                return
            }
        }
        
        guard let data = data else {
            compleationHandler(false,error)
            return
        }
        compleationHandler(true,data)
    }
}
extension URLResponse {
    
    var isSuccessStausCode:Bool {
       if let httpResponse = self as? HTTPURLResponse {
            return (200...299).contains(httpResponse.statusCode)
        }
        return false
    }

}
