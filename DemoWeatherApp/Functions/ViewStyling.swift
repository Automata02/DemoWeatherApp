//
//  ViewStyling.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 11/09/2022.
//

import Foundation
import UIKit

func styleView(views: [UIView]) {
    for view in views {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 8
        view.layer.cornerRadius = 10
    }
}
