//
//  FavoritePresentation.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import CoreData

class FavoritePresentation: FavoritePresenter {
    
    private let view: FavoritesView!
    private let context: NSManagedObjectContext!
    
    init(view: FavoritesView, delegate: AppDelegate?) {
        context = delegate?.persistentContainer.viewContext
        self.view = view
    }
    
    func onGetFavoriteMovies() {
        let repo: MovieRepository = MovieRepository()
        repo.load(context: context, onSuccess: { [weak self] (results) in
            guard let self = self else {return}
            if results.count <= 0 {
                self.view.onFavoriteMovieEmpty()
            } else {
                var favoriteMovies: [MovieDetail] = []
                results.forEach { (favoriteMovie) in
                    let releaseDate: String = favoriteMovie.releaseDate?.reformatString(from: .dateWithStripReversed, to: .monthFullName) ?? Date().dateToString(withFormat: .monthFullName)
                    let movie: MovieDetail = MovieDetail(
                        id: Int(favoriteMovie.id),
                        overview: favoriteMovie.overview ?? "",
                        posterPath: favoriteMovie.posterPath ?? "",
                        releaseDate: releaseDate,
                        title: favoriteMovie.title ?? "",
                        isFavorited: true
                    )
                    favoriteMovies.append(movie)
                }
                self.view.onGetFavoriteMovies(movies: favoriteMovies)
            }
        }) { [weak self] (err) in
            guard let self = self else {return}
            self.view.showError(msg: err.localizedDescription)
        }
    }
}
