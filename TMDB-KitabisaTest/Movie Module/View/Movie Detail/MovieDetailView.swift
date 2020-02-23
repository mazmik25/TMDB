//
//  MovieDetailView.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

protocol MovieDetailView: BaseView {
    func onGetDetail(movie: MovieDetail)
    func onGetReviews(reviews: [MovieReviewsOutput])
    func onFavoriteSaved()
    func onFavoriteRemoved()
}
