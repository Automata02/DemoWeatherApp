//
//  NewUserCheck.swift
//  DemoWeatherApp
//
//  Created by roberts.kursitis on 02/11/2022.
//

import Foundation

class NewUserCheck {
    
    static let shared = NewUserCheck()
    
    //MARK: Returns true for new user once the function is called
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func notNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
