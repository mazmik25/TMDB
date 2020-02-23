//
//  MovieDetailPresentation.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 23/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import CoreData

class MovieDetailPresentation: MovieDetailPresenter {
    
    private let view: MovieDetailView!
    private let context: NSManagedObjectContext!
    private let repo: MovieRepository = MovieRepository()
    private let apiKey: String = "44755119354772a89e87cfd9ccef85f3"
    
    init(view: MovieDetailView, delegate: AppDelegate?) {
        self.view = view
        context = delegate?.persistentContainer.viewContext
    }
    
    func onGetMovieReview(byId id: Int) {
        let request: GetMovieReviewsBodyRequest = GetMovieReviewsBodyRequest(apiKey: apiKey, movieId: id)
        view.onLoading(msg: "Looking for moview reviews")
        repo.getReviews(request: request, onSuccess: { [weak self] (results) in
            guard let self = self else { return }
            self.view.onFinishLoading()
            if results.count > 0 {
                self.view.onGetReviews(reviews: results)
            }
        }) { (err) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view.onFinishLoading()
                self.view.showError(msg: err.localizedDescription)
            }
        }
    }
    
    func onSwapToDetail(input: MoviesOutput) {
        var movieDetail: MovieDetail = MovieDetail(id: input.id, overview: input.overview, posterPath: input.posterPath, releaseDate: input.releaseDate, title: input.title, isFavorited: false)
        repo.load(byId: Int64(input.id), context: context, onSuccess: { [unowned self] (results) in
            if let _: FavoriteMovie = results.first {
                movieDetail.isFavorited = true
                self.view.onGetDetail(movie: movieDetail)
            } else { self.view.onGetDetail(movie: movieDetail) }
        }) { [unowned self] (err) in
            self.view.showError(msg: err.localizedDescription)
        }
    }
    
    func onSaveFavoriteMovie(input: MovieDetail) {
        repo.save(context: context, movie: input, onSuccess: { [unowned self] in
            self.view.onFavoriteSaved()
        }) { [unowned self] (err) in
            self.view.showError(msg: err.localizedDescription)
        }
    }
    
    func onRemoveFavoriteMovie(input: MovieDetail) {
        repo.load(byId: Int64(input.id), context: context, onSuccess: { [unowned self] (results) in
            if let movie: FavoriteMovie = results.first {
                self.deleteFavoriteMovie(movie: movie)
            } else { self.view.showError(msg: "Failed to delete favorite movie") }
        }) { [unowned self] (err) in
            self.view.showError(msg: err.localizedDescription)
        }
    }
    
    private func deleteFavoriteMovie(movie: FavoriteMovie) {
        repo.delete(context: context, movie: movie, onSuccess: {
            self.view.onFavoriteRemoved()
        }, onFailure: { (err) in
            self.view.showError(msg: err.localizedDescription)
        })
    }
}
