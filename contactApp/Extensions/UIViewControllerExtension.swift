//
//  UIViewControllerExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTitle(title _: String) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        title = "Contact"
    }

    func showLoader() {
        let blurLoader = BlurLoader(frame: view.frame)
        view.addSubview(blurLoader)
    }

    func hideLoader() {
        if let blurLoader = self.view.subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }

    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }

    @objc func dismissControllerAnimatted() {
        dismiss(animated: true, completion: nil)
    }

    @objc func dismissControllerNotAnimatted() {
        dismissKeyboard()
        navigationController?.dismiss(animated: false, completion: nil)
    }

    func hideKeyboardOnTouchOutside() {
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapToDismiss.cancelsTouchesInView = false
        view.addGestureRecognizer(tapToDismiss)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlert(alertTitle title: String?, alertMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController: StoryboardIdentifiable {}
