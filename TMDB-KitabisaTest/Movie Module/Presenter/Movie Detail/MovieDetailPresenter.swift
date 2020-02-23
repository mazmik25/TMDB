//
//  MovieDetailPresenter.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
protocol MovieDetailPresenter {
    func onSwapToDetail(input: MoviesOutput)
    func onGetMovieReview(byId id: Int)
    func onSaveFavoriteMovie(input: MovieDetail)
    func onRemoveFavoriteMovie(input: MovieDetail)
}
