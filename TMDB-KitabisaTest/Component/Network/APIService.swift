//
//  APIService.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Alamofire

typealias OnGetResponse<T> = ((T)->Void)?
typealias OnSuccessResult<T> = ((Result<T, Error>)->Void)?
typealias OnFailed = ((Error)->Void)?

class APIService<T: Codable> {
    private let api: APIBlueprint!
    private let env: APIEnvironment!
    
    init(api: APIBlueprint, env: APIEnvironment) {
        self.api = api
        self.env = env
    }
    
    func callApi(onCompleted: OnSuccessResult<T>) {
        let url: String = api.setupUrl(env: env)
        let encoding: ParameterEncoding = api.httpMethod == .get ? URLEncoding(destination: .queryString) : JSONEncoding.default
        AF.request(url, method: api.getMethod(), parameters: api.parameters, encoding: encoding, headers: api.headers)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let model):
                guard let responseJSON = model as? [String:Any] else {return}
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: responseJSON, options: .prettyPrinted)
                    let decoder: JSONDecoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model: T = try decoder.decode(T.self, from: data)
                    onCompleted?(.success(model))
                } catch let error { onCompleted?(.failure(error))  }
                #if DEBUG
                    ApiLogger.logger(url: url, api: self.api, responseJSON: responseJSON)
                #endif
                break
            case .failure(let error):
                onCompleted?(.failure(error))
                #if DEBUG
                    ApiLogger.logger(url: url, api: self.api, responseJSON: nil)
                #endif
                break
            }
        }
    }
}

final class ApiLogger {
    static func logger(url: String, api: APIBlueprint, responseJSON: [String:Any]?) {
        print("URL \(url)")
        print("METHOD \(api.httpMethod.rawValue)")
        print("REQUEST.HEADER \(api.headers)")
        print("REQUEST.BODY \(api.parameters)")
        print("RESPONSE.BODY \(responseJSON ?? [:])")
    }
}
