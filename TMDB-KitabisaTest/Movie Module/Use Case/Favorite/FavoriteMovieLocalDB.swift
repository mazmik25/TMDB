//
//  FavoriteMovieLocalDB.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import CoreData

class FavoriteMovieLocalDB: LocalDBService<FavoriteMovie, MovieDetail> {
    override func save(input: MovieDetail, onSuccess: OnLocalSuccess, onFailure: OnFailed) {
        let favoriteMovie: FavoriteMovie = FavoriteMovie(context: context)
        favoriteMovie.id = Int64(input.id)
        favoriteMovie.overview = input.overview
        favoriteMovie.posterPath = input.posterPath
        favoriteMovie.releaseDate = input.releaseDate
        favoriteMovie.title = input.title
        do {
            try context.save()
            onSuccess?()
        } catch {
            onFailure?(error)
        }
    }
}
