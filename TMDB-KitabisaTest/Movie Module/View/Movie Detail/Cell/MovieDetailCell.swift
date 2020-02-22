//
//  MovieDetailCell.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

protocol MovieDetailCellDelegate: class {
    func onFavoriteTapped(at index: Int)
}

class MovieDetailCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var synopsyisLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: MovieDetailCellDelegate?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(delegate: MovieDetailCellDelegate, index: Int, movie: MoviesOutput) {
        self.delegate = delegate
        self.index = index
        attachModel(movie: movie)
    }
    
    private func attachModel(movie: MoviesOutput) {
        posterImageView.loadPoster(path: movie.posterPath)
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        synopsyisLabel.text = movie.overview
    }
    
    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        delegate?.onFavoriteTapped(at: index)
    }
    
}
