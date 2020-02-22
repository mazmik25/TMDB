//
//  MoviesPresentation.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class MoviesPresentation: MoviesPresenter {
    
    private let view: MoviesView!
    private let apiKey: String = "44755119354772a89e87cfd9ccef85f3"
    init(view: MoviesView) {
        self.view = view
    }
    
    func onGetMoview(withCategory category: MovieCategory, onPage page: Int) {
        view.onLoading(msg: "Retrieving movies . . .")
        let repo: MovieRepository = MovieRepository()
        let request: GetMoviesBodyRequest = GetMoviesBodyRequest(apiKey: apiKey, page: page)
        repo.getMovies(withCategory: category, request: request, onSuccess: { [weak self] (results) in
            guard let self = self else {return}
            self.view.onFinishLoading()
            if results.count < 0 {
                DispatchQueue.main.async {
                    self.view.onMoviesEmpty()
                }
            } else {
                DispatchQueue.main.async {
                    self.view.onGetMovies(movies: results)
                }
            }
        }) { (err) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.view.onFinishLoading()
                self.view.showError(msg: err.localizedDescription)
            }
        }
    }
}
