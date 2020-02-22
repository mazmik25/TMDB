//
//  GetTopRatedMoviesAPI.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class GetTopRatedMoviesAPI: APIBlueprint {
    var parameters: [String : Any]
    var httpMethod: HttpMethod = .get
    var headers: Headers = [:]
    var route: String = "/movie/top_rated"
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
    }
}
