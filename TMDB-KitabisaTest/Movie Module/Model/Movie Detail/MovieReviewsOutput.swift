//
//  MovieReviewsOutput.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
struct MovieReviewsOutput: Codable {
    let author: String
    let content: String
    let id: String
    let url: String
}
