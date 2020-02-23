//
//  MovieRepository.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
import CoreData
final class MovieRepository {
    
    private let errorParsing: Error = NSError(domain: "Terjadi kesalahan dalam aplikasi", code: 523, userInfo: nil)
    private let env: TMDBEnvironment = TMDBEnvironment()
    
    func getMovies(withCategory category: MovieCategory, request: GetMoviesBodyRequest, onSuccess: OnGetResponse<[MoviesOutput]>, onFailure: OnFailed) {
        if let dict = request.dict {
            let api: APIBlueprint = setupAPI(basedOnCategory: category, params: dict)
            let service: APIService = APIService<GetMoviesBodyResponse>(api: api, env: env)
            service.callApi { result in
                switch result {
                case .success(let response):
                    let output: [MoviesOutput] = self.swapToOutput(from: response)
                    onSuccess?(output)
                case .failure(let err):
                    onFailure?(err)
                }
            }
        } else {
            onFailure?(errorParsing)
        }
    }
    
    private func swapToOutput(from model: GetMoviesBodyResponse) -> [MoviesOutput] {
        var outputs: [MoviesOutput] = []
        model.results.forEach { (response) in
            if let date = response.releaseDate {
                let releaseDate: String = date.reformatString(from: .dateWithStripReversed, to: .monthFullName)
                let output: MoviesOutput = MoviesOutput(id: response.id ?? 0, overview: response.overview ?? "", posterPath: response.posterPath ?? "", releaseDate: releaseDate, title: response.title ?? "")
                outputs.append(output)
            }
        }
        return outputs
    }
    
    private func setupAPI(basedOnCategory category: MovieCategory, params: [String:Any]) -> APIBlueprint {
        switch category {
        case .nowPlaying:
            return GetNowPlayingMoviesAPI(parameters: params)
        case .popular:
            return GetPopularMoviesAPI(parameters: params)
        case .topRated:
            return GetTopRatedMoviesAPI(parameters: params)
        case .upcoming:
            return GetUpcomingMoviesAPI(parameters: params)
        }
    }
    
    func getReviews(request: GetMovieReviewsBodyRequest, onSuccess: OnGetResponse<[MovieReviewsOutput]>, onFailure: OnFailed) {
        if let dict = request.dict {
            let api: GetMovieReviewsAPI = GetMovieReviewsAPI(parameters: dict)
            api.parameters.removeValue(forKey: "movie_id")
            let service: APIService = APIService<GetMovieReviewsBodyResponse>(api: api, env: env)
            service.callApi { (result) in
                switch result {
                case .success(let response):
                    let outputs: [MovieReviewsOutput] = self.swapToOutput(from: response.results)
                    onSuccess?(outputs)
                case .failure(let err):
                    onFailure?(err)
                }
            }
        } else {
            onFailure?(errorParsing)
        }
    }
    
    private func swapToOutput(from model: [GetMovieReviewsFullBodyResponse]) -> [MovieReviewsOutput] {
        var outputs: [MovieReviewsOutput] = []
        model.forEach { (response) in
            let output: MovieReviewsOutput = MovieReviewsOutput(author: response.author, content: response.content, id: response.id, url: response.url)
            outputs.append(output)
        }
        return outputs
    }
    
    func save(context: NSManagedObjectContext, movie: MovieDetail, onSuccess: OnLocalSuccess, onFailure: OnFailed) {
        let localDB: LocalDBService = FavoriteMovieLocalDB(context: context)
        localDB.save(input: movie, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func load(context: NSManagedObjectContext, onSuccess: OnGetLocalData<FavoriteMovie>, onFailure: OnFailed) {
        let localDB: LocalDBService = FavoriteMovieLocalDB(context: context)
        localDB.load(onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func load(byId id: Int64, context: NSManagedObjectContext, onSuccess: OnGetLocalData<FavoriteMovie>, onFailure: OnFailed) {
        let localDB: LocalDBService = FavoriteMovieLocalDB(context: context)
        let predicate: NSPredicate = NSPredicate(format: "id == %d", id)
        localDB.load(predicate: predicate, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func delete(context: NSManagedObjectContext, movie: FavoriteMovie, onSuccess: OnLocalSuccess, onFailure: OnFailed) {
        let localDB: LocalDBService = FavoriteMovieLocalDB(context: context)
        localDB.delete(entity: movie, onSuccess: onSuccess, onFailure: onFailure)
    }
}
