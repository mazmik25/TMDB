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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
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

}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath) as? MovieDetailCell else{return UITableViewCell()}
        cell.setupView(delegate: self, index: indexPath.row, movie: movie)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieDetailVC: MovieDetailCellDelegate {
    func onFavoriteTapped(at index: Int) {
        
    }
}
