//
//  APIBlueprint.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Alamofire
typealias Headers = HTTPHeaders

enum ContentType: String {
    case json = "application/json"
    case formUrlEncoded = "application/x-www-form-urlencoded"
}

protocol APIBlueprint {
    var parameters: [String:Any] {get}
    var httpMethod: HttpMethod {get}
    var headers: Headers {get}
    var route: String {get}
}

extension APIBlueprint {
    func setupUrl(env: APIEnvironment) -> String {
        let baseUrl: String = env.setupBaseUrl()
        return "\(baseUrl)\(route)"
    }
    
    func getMethod() -> HTTPMethod {
        return HTTPMethod(rawValue: httpMethod.rawValue)
    }
}
