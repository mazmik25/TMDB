//
//  APIEvnvironment.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation

//Blueprint for Environment
protocol APIEnvironment {
    var debug: String {get}
    var prod: String {get}
}

extension APIEnvironment {
    func setupBaseUrl() -> String {
        #if DEBUG
            return debug
        #else
            return prod
        #endif
    }
}

class TMDBEnvironment: APIEnvironment {
    var debug: String = "https://api.themoviedb.org/3"
    var prod: String = "https://api.themoviedb.org/3"
}
