//
//  MovieCell.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var containerView: ShadowView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var synopsyisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(movie: MoviesOutput) {
        posterImageView.setupRadius(type: .custom(4.0), isMaskToBounds: true)
        posterImageView.loadPoster(path: movie.posterPath)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        synopsyisLabel.text = movie.overview
    }
    
    func attachModel(movie: MovieDetail) {
        let output: MoviesOutput = MoviesOutput(id: movie.id, overview: movie.overview, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title)
        setupView(movie: output)
    }
}
