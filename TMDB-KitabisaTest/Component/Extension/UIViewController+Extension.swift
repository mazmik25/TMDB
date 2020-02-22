//
//  UIViewController+Extension.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit
extension UIViewController {
    func setupHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
    func backToPreviousVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func backToRootVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func pushVC<V: UIViewController>(_ vc: V) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func present<V: UIViewController>(_ vc: V, isFullScreen: Bool = false, isWithNavController: Bool = false, completion: (()->Void)? = nil) {
        if isWithNavController {
            let navController = UINavigationController(rootViewController: vc)
            if #available(iOS 13.0, *) {
                navController.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(navController, animated: true, completion: completion)
        } else {
            if #available(iOS 13.0, *) {
                vc.modalPresentationStyle = isFullScreen ? .fullScreen : .automatic
            }
            present(vc, animated: true, completion: completion)
        }
    }
}
