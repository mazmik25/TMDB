//
//  GetMovieReviewsAPI.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class GetMovieReviewsAPI: APIBlueprint {
    var parameters: [String : Any]
    var httpMethod: HttpMethod = .get
    var headers: Headers = [:]
    var route: String = "/movie"
    
    init(parameters: [String:Any]) {
        self.parameters = parameters
        let id: Int = parameters["movie_id"] as! Int
        route += "/\(id)/reviews"
    }
}
