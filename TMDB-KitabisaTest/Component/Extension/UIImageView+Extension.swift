//
//  UIImageView+Extension.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func imageFromUrl(urlString: String) {
        AF.request(urlString).responseImage { response in
            switch response.result {
            case .success(let image):
                self.image = image
            case .failure(_):
                self.image = UIImage(named: "image-placeholder")
            }
        }
    }
    
    func loadPoster(path: String) {
        let posterPath: String = "https://image.tmdb.org/t/p/w500\(path)"
        imageFromUrl(urlString: posterPath)
    }
}
