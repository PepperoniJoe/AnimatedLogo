//
//  Alert.swift
//  AnimatedLogo
//
//  Created by Marcy Vernon on 6/28/20.
//  Copyright © 2020 Marcy Vernon. All rights reserved.
//

import UIKit

//MARK: Reusable Alert for view controllers
extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        present(alert, animated: true, completion: nil)
    }
}
