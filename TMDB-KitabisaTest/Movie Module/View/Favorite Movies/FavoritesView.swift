//
//  FavoritesView.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

protocol FavoritesView: BaseView {
    func onGetFavoriteMovies(movies: [MovieDetail])
    func onFavoriteMovieEmpty()
}
