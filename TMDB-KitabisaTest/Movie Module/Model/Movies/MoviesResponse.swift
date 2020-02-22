//
//  GetMoviesResponse.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation

struct GetMoviesBodyRequest: Codable {
    let apiKey: String
    let page: Int
}

struct GetMoviesBodyResponse: Codable {
    let dates : MovieDateResponse?
    let page : Int
    let results : [GetMoviesFullBodyResponse]
    let totalPages : Int
    let totalResults : Int
}

struct GetMoviesFullBodyResponse: Codable {
    let adult : Bool
    let backdropPath : String
    let genreIds : [Int]
    let id : Int
    let originalLanguage : String
    let originalTitle : String
    let overview : String
    let popularity : Double
    let posterPath : String
    let releaseDate : String
    let title : String
    let video : Bool
    let voteAverage : Float
    let voteCount : Int
}

struct MovieDateResponse: Codable {
    let maximum : String
    let minimum : String
}
