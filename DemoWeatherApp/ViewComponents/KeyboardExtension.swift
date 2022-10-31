//
//  KeyboardExtension.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 07/09/2022.
//

import Foundation
import UIKit

extension MainViewController {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(MainViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }

}
