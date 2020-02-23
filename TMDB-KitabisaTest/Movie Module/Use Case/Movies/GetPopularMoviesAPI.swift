//
//  GetPopularMoviesAPI.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class GetPopularMoviesAPI: APIBlueprint {
    var parameters: [String : Any]
    var httpMethod: HttpMethod = .get
    var headers: Headers = [:]
    var route: String = "/movie/popular"
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}
