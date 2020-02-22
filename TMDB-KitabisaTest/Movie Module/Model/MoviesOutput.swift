//
//  File.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
struct MoviesOutput: Codable {
    let overview : String
    let posterPath : String
    let releaseDate : String
    let title : String
}
