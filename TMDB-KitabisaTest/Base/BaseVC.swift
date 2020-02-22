//
//  BaseVC.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit
import ProgressHUD

class BaseVC: UIViewController, BaseView {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func onLoading(msg: String) {
        ProgressHUD.show(msg)
    }
    
    func onFinishLoading() {
        ProgressHUD.dismiss()
    }
    
    func showError(msg: String) {
        alertError(msg: msg)
    }
    
    func setupAlertController(title: String?, message: String?, style: UIAlertController.Style = .alert) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        return alert
    }
    
    func setupAlertAction(title: String, style: UIAlertAction.Style, completion: (()->Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: { _ in
            completion?()
        })
    }
    
    func setupCancelAction() -> UIAlertAction {
        return setupAlertAction(title: "Cancel", style: .destructive, completion: nil)
    }
    
    private func alertError(msg: String) {
        let alert = setupAlertController(title: "Error Found!", message: msg)
        alert.addAction(setupAlertAction(title: "OK", style: .default, completion: {
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    
    func categoryActionSheet(delegate: CategoryDelegate) {
        
    }
}

protocol CategoryDelegate: class {
    func onPopularSelected()
    func onUpcomingSelected()
    func onTopRatedSelected()
    func onNowPlayingSelected()
}
