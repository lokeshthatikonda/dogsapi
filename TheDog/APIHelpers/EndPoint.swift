//
//  EndPoint.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
}
let API_KEY = "live_DMf97Dnq24aaZR2bMvAWN1hkutzzr80ZfTZ8OYIwS7dRvaJXkn6kxgygp1Dphl4r"

class EndPoint {

    var path:String = ""
    var urlParameters:[String:Any] = [:]
    var method: HTTPMethod = HTTPMethod.get
    var headers:[String:Any] = ["x-api-key":API_KEY]
    
    init(path:String? = "", urlParameters:[String:Any]? = [:], headers:[String:Any]? = [:], method:HTTPMethod? = .get) {
        self.path = path ?? ""
        self.urlParameters = urlParameters ?? [:]
        self.headers.merge(headers ?? [:]) { (current, _) in current }
        self.method = method!
    }
    
}
