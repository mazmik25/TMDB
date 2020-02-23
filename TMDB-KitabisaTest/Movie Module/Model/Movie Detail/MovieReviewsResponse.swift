//
//  GetMovieReviews.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
struct GetMovieReviewsBodyRequest: Codable {
    let apiKey: String
    let movieId: Int
}

struct GetMovieReviewsBodyResponse: Codable {
    let id: Int
    let page: Int
    let results: [GetMovieReviewsFullBodyResponse]
    let totalPages: Int
    let totalResults: Int
}
//"author": "Goddard",
//"content": "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.",
//"id": "5b1c13b9c3a36848f2026384",
//"url": "https://www.themoviedb.org/review/5b1c13b9c3a36848f2026384"
struct GetMovieReviewsFullBodyResponse: Codable {
    let author: String
    let content: String
    let id: String
    let url: String
}
