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
                self.generateSuccessResult(responseJSON: responseJSON, onCompleted: onCompleted)
                print("HEADERS \(response.response?.allHeaderFields ?? [:])")
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
    
    private func generateSuccessResult(responseJSON: [String:Any], onCompleted: OnSuccessResult<T>) {
        if let code = responseJSON["status_code"] as? Int {
            if code == 200 || code == 201 {
                onCompleted?(
                    handleDecoderModel(responseJSON: responseJSON, code: code)
                )
            } else {
                onCompleted?(
                    createErrorParsing(responseJSON: responseJSON, code: code)
                )
            }
        } else {
            onCompleted?(.failure(NSError(domain: "Failed to parse data", code: 523, userInfo: nil)))
        }
    }
    
    private func handleDecoderModel(responseJSON: [String:Any], code: Int) -> Result<T, Error> {
        do {
            var data: Data = Data()
            if let responseData = responseJSON["data"] as? [String:Any] {
                data = try JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted)
            } else if let responsesData = responseJSON["data"] as? [[String:Any]] {
                data = try JSONSerialization.data(withJSONObject: responsesData, options: .prettyPrinted)
            } else { return .failure(NSError(domain: "Failed to parse data", code: code, userInfo: nil)) }
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model: T = try decoder.decode(T.self, from: data)
            return .success(model)
        } catch let error { return .failure(error) }
    }
    
    private func createErrorParsing(responseJSON: [String:Any], code: Int) -> Result<T, Error> {
        var error: Error
        if let message = responseJSON["message"] as? String { error = NSError(domain: message, code: code, userInfo: nil) }
        else { error = NSError(domain: "Failed to parse data", code: code, userInfo: nil) }
        return .failure(error)
    }
}

class ApiLogger {
    static func logger(url: String, api: APIBlueprint, responseJSON: [String:Any]?) {
        print("URL \(url)")
        print("METHOD \(api.httpMethod.rawValue)")
        print("REQUEST.HEADER \(api.headers)")
        print("REQUEST.BODY \(api.parameters)")
        print("RESPONSE.BODY \(responseJSON ?? [:])")
    }
}
