//
//  FavoritesVC.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class FavoritesVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var favoriteMovies: [MovieDetail] = []
    var presenter: FavoritePresenter!
    private var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTitle(title: "Favorite Movie")
        setupBackNavigation()
        presenter.onGetFavoriteMovies()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupPresenter() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        presenter = FavoritePresentation(view: self, delegate: appDelegate)
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else{return UITableViewCell()}
        cell.attachModel(movie: favoriteMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailVC()
        vc.movieDetail = favoriteMovies[indexPath.row]
        pushVC(vc)
    }
}

extension FavoritesVC: FavoritesView {
    func onGetFavoriteMovies(movies: [MovieDetail]) {
        infoLabel.isHidden = true
        tableView.isHidden = false
        favoriteMovies = movies
        tableView.reloadData()
    }
    
    func onFavoriteMovieEmpty() {
        infoLabel.isHidden = false
        tableView.isHidden = true
        tableView.reloadData()
    }
}
