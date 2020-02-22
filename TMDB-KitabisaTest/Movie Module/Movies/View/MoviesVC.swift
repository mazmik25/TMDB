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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UITableViewCell()}
        cell.setupView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FavoritesVC()
        pushVC(vc)
    }
}

extension MoviesVC: MoviesView {
    func onGetMovies() {
        
    }
    
    func onMoviesEmpty() {
        
    }
    
    func onPopularSelected() {
        
    }
    
    func onUpcomingSelected() {
        
    }
    
    func onTopRatedSelected() {
        
    }
    
    func onNowPlayingSelected() {
        
    }
}
