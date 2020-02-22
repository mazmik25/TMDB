//
//  UIView+Extension.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

enum RadiusType {
    case rounded
    case quarter
    case custom(CGFloat)
}

extension UIView {
    
    func setupRadius(type: RadiusType, isMaskToBounds: Bool = false) {
        var radius: CGFloat = 0.0
        
        switch type {
        case .rounded:
            radius = frame.width / 2
        case .quarter:
            radius = frame.width / 4
        case .custom(let value):
            radius = value
        }
        
        layer.cornerRadius = radius
        layer.masksToBounds = isMaskToBounds
    }
    
    func setupBorder(color: UIColor = .black, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
