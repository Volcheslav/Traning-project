//
//  AlertWindows.swift
//  Training Project
//
//  Created by VironIT on 8/12/22.
//

import UIKit

class AlertWindows: UIAlertController {
    static func showAlertText(window: @escaping () -> Void, message: String, viewcontroller: UIViewController, okButtonTitle: String) {
        let alert2 = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alert2.addAction(UIAlertAction(title: okButtonTitle, style: .default) { _ in window() })
        alert2.addCancelAction()
        viewcontroller.present(alert2, animated: true)
    }
    
    static func showAlertText(window: @escaping () -> Void, message: String, viewcontroller: UIViewController) {
        let alert2 = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alert2.addAction(UIAlertAction(title: "OK", style: .default) { _ in window() })
        alert2.addCancelAction()
        viewcontroller.present(alert2, animated: true)
    }
}

extension UIAlertController {
    func addCancelAction () {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}
