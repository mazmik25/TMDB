//
//  MovieDetailVC.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class MovieDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    var movie: MoviesOutput!
    var movieDetail: MovieDetail?
    var presenter: MovieDetailPresenter!
    
    private var reviews: [MovieReviewsOutput] = []
    private var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTitle(title: "Movie Detail")
        setupBackNavigation()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: "MovieDetailCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupPresenter() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        presenter = MovieDetailPresentation(view: self, delegate: appDelegate)
        if let movieDetail = movieDetail {
            tableView.reloadData()
            presenter.onGetMovieReview(byId: movieDetail.id)
        } else {
            presenter.onSwapToDetail(input: movie)
        }
    }

}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return setupMovieDetailCell(tableView)
        } else {
            return setupMovieReviewCell(indexPath: indexPath)
        }
    }
    
    private func setupMovieDetailCell(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell") as? MovieDetailCell, let movieDetail = movieDetail else {return UITableViewCell()}
        cell.setupView(delegate: self, movie: movieDetail)
        cell.selectionStyle = .none
        return cell
    }
    
    private func setupMovieReviewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let index: Int = indexPath.row - 1
        let review: MovieReviewsOutput = reviews[index]
        if reviews.count > 0 {
            cell.textLabel?.text = review.author
            cell.detailTextLabel?.text = review.content
            cell.detailTextLabel?.numberOfLines = 4
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieDetailVC: MovieDetailView, MovieDetailCellDelegate {
    func onGetDetail(movie: MovieDetail) {
        movieDetail = movie
        presenter.onGetMovieReview(byId: movie.id)
        tableView.reloadData()
    }
    
    func onGetReviews(reviews: [MovieReviewsOutput]) {
        self.reviews = reviews
        tableView.reloadData()
    }
    
    func onFavoriteSaved() {
        tableView.reloadData()
    }
    
    func onFavoriteRemoved() {
        tableView.reloadData()
    }
    
    func onFavoriteTapped() {
        movieDetail!.isFavorited = !movieDetail!.isFavorited
        let isFavorited: Bool = movieDetail!.isFavorited
        if isFavorited { presenter.onSaveFavoriteMovie(input: movieDetail!) }
        else { presenter.onRemoveFavoriteMovie(input: movieDetail!) }
        tableView.reloadData()
    }
}
