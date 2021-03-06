//
//  MoviesVC.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class MoviesVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    private var movies: [MoviesOutput] = []
    private var presenter: MoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTitle(title: Bundle.main.infoDictionary?["CFBundleName"] as? String)
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        let image = UIImage(named: "heart")
        let favoriteButtonItem: UIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveToFavorite))
        favoriteButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = favoriteButtonItem
    }
    
    @objc private func moveToFavorite() {
        let vc = FavoritesVC()
        pushVC(vc)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupPresenter() {
        presenter = MoviesPresentation(view: self)
        presenter.onGetMoview(withCategory: .nowPlaying, onPage: 1)
    }
    
    @IBAction func onCategoryTapped(_ sender: UIButton) {
        let alert = setupAlertController(title: "Select Category", message: nil, style: .actionSheet)
        alert.addAction(setupAlertAction(title: "Popular", style: .default, completion: onPopularSelected))
        alert.addAction(setupAlertAction(title: "Upcoming", style: .default, completion: onUpcomingSelected))
        alert.addAction(setupAlertAction(title: "Top Rated", style: .default, completion: onTopRatedSelected))
        alert.addAction(setupAlertAction(title: "Now Playing", style: .default, completion: onNowPlayingSelected))
        alert.addAction(setupCancelAction())
        present(alert, animated: true)
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        cell.setupView(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailVC()
        vc.movie = movies[indexPath.row]
        pushVC(vc)
    }
}

extension MoviesVC: MoviesView {
    func onGetMovies(movies: [MoviesOutput]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func onMoviesEmpty() {
        tableView.reloadData()
    }
    
    func onPopularSelected() {
        presenter.onGetMoview(withCategory: .popular, onPage: 1)
    }
    
    func onUpcomingSelected() {
        presenter.onGetMoview(withCategory: .upcoming, onPage: 1)
    }
    
    func onTopRatedSelected() {
        presenter.onGetMoview(withCategory: .topRated, onPage: 1)
    }
    
    func onNowPlayingSelected() {
        presenter.onGetMoview(withCategory: .nowPlaying, onPage: 1)
    }
}
