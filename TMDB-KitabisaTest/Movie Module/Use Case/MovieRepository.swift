//
//  MovieRepository.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
final class MovieRepository {
    
    private let errorParsing: Error = NSError(domain: "Terjadi kesalahan dalam aplikasi", code: 523, userInfo: nil)
    
    func getMovies(withCategory category: MovieCategory, request: GetMoviesBodyRequest, onSuccess: OnGetResponse<[MoviesOutput]>, onFailure: OnFailed) {
        
        if let dict = request.dict {
            let api: APIBlueprint = setupAPI(basedOnCategory: category, params: dict)
            let service: APIService<GetMoviesBodyResponse> = APIService<GetMoviesBodyResponse>(api: api, env: TMDBEnvironment())
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
            let releaseDate: String = response.releaseDate.reformatString(from: .dateWithStripReversed, to: .monthFullName)
            let output: MoviesOutput = MoviesOutput(id: response.id, overview: response.overview, posterPath: response.posterPath, releaseDate: releaseDate, title: response.title)
            outputs.append(output)
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
}
