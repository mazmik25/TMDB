//
//  BaseView.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import Foundation
protocol BaseView {
    func showError(msg: String)
    func onLoading(msg: String)
    func onFinishLoading()
}
