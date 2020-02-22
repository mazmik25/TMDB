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
    
    func setupView(delegate: MovieDetailCellDelegate, index: Int) {
        self.delegate = delegate
        self.index = index
    }
    
    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        delegate?.onFavoriteTapped(at: index)
    }
    
}
