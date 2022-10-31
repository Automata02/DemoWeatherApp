//
//  SettingsViewController.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 08/09/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    private var theme: Theme {
        get {
            return defaults.theme
        }
        set {
            defaults.theme = newValue
            configureStyle(for: newValue)
        }
    }
    
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var appearanceView: UIView!
    @IBOutlet weak var notificationsView: UIView!
    @IBOutlet weak var notificationSwitchOutlet: UISwitch!
    @IBOutlet weak var timeStack: UIStackView!
    @IBOutlet weak var timeOutlet: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView(views: [appearanceView, notificationsView])
        setupPopup()
        setupNotificationView()
    }
    
    @IBAction func notificationSwitch(_ sender: Any) {
        if notificationSwitchOutlet.isOn {
            timeStack.isHidden = false
            defaults.set(true, forKey: "haveNotification")
            print("notification set")
        } else {
            timeStack.isHidden = true
            defaults.set(false, forKey: "haveNotification")
            print("notification disabled")
        }
    }
    @IBAction func timePicker(_ sender: Any) {
        defaults.set(timeOutlet.date, forKey: "notificationTime")
        if (captionUN != nil) && (temperatureUN != nil) {
            setupNotification(weather: captionUN ?? "is aigh", temp: temperatureUN ?? 0)
        }
    }
    func setupNotificationView() {
        if defaults.object(forKey: "notificationTime") != nil {
            timeOutlet.date = defaults.object(forKey: "notificationTime") as! Date
        }
        if !defaults.bool(forKey: "haveNotification") {
            notificationSwitchOutlet.setOn(false, animated: true)
            timeStack.isHidden = true
        } else {
            notificationSwitchOutlet.setOn(true, animated: true)
            timeStack.isHidden = false
        }
    }
    
    func setupPopup() {
        let actions = [
            UIAction(title: "System", state: .off) {_ in
                self.configureStyle(for: .device)
                self.defaults.theme = .device
            },
            UIAction(title: "Dark", state: .off) {_ in
                self.configureStyle(for: .dark)
                self.defaults.theme = .dark
            },
            UIAction(title: "Light", state: .off) {_ in
                self.configureStyle(for: .light)
                self.defaults.theme = .light
            }]
        
        for action in actions {
            if defaults.theme.rawValue == 0, action.title == "System" {
                action.state = .on
            } else if defaults.theme.rawValue == 1, action.title == "Light" {
                action.state = .on
            } else if defaults.theme.rawValue == 2, action.title == "Dark" {
                action.state = .on
            }
        }
        
        self.popupButton.menu = UIMenu(children: actions)
        popupButton.showsMenuAsPrimaryAction = true
        popupButton.changesSelectionAsPrimaryAction = true
        popupButton.layer.shadowColor = UIColor.black.cgColor
        popupButton.layer.shadowOpacity = 0.3
        popupButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        popupButton.layer.shadowRadius = 4
    }
    
    private func configureStyle(for theme: Theme) {
      view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}

extension UserDefaults {
    var theme: Theme {
        get {
            register(defaults: [#function: Theme.device.rawValue])
            return Theme(rawValue: integer(forKey: #function)) ?? .device
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
