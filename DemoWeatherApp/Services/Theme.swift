//
//  Theme.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 08/09/2022.
//

import UIKit

enum Theme: Int {
  case device
  case light
  case dark
}

extension Theme {
  var userInterfaceStyle: UIUserInterfaceStyle {
    switch self {
      case .device:
        return .unspecified
      case .light:
        return .light
      case .dark:
        return .dark
    }
  }
}
