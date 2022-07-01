//
//  UIViewController+Alert.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
