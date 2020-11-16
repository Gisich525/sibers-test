//
//  UIViewController+Alert.swift
//  siberstest
//
//  Created by guest1 on 16.11.2020.
//

import UIKit

extension UIViewController {
    func showAlertWith(title: String, actionTitle: String, action: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in action() }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
