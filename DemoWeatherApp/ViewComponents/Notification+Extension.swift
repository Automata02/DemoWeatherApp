//
//  NotificationExtension.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 11/09/2022.
//

import UIKit
import UserNotifications

extension SettingsViewController: UNUserNotificationCenterDelegate {
    
    func setupNotification(weather: String, temp: Double) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("agreed to notifications")
                self.scheduleLocal(delaySeconds: 10, weather: weather, temp: temp)
            } else {
                print("denied notifications")
            }
        }
    }
    
    func scheduleLocal(delaySeconds: TimeInterval, weather: String, temp: Double) {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Hello there!"
        content.body = "The weather outside is \(weather) with a temerature of \(temp)°"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "🤷"]
        content.sound = .default
        
        var notificationTime = DateComponents()
        
        if defaults.object(forKey: "notificationTime") != nil {
            let setDate = defaults.object(forKey: "notificationTime") as! Date
            let calendar = Calendar.current
            notificationTime = calendar.dateComponents([.hour, .minute], from: setDate)
        } else {
            notificationTime.hour = 8
            notificationTime.minute = 00
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        //MARK: Trigger notification after 5s
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print("notification was set for \(notificationTime)")
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "Show", title: "Launch App", options: .foreground)
        // .foreground launches app
        let dismiss = UNNotificationAction(identifier: "Remove", title: "Dismiss", options: .destructive)
        let remind = UNNotificationAction(identifier: "Later", title: "Remind me later", options: [])
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind, dismiss], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //user swiped to unlock
                print("Default identifier")
            case "Show":
                print("Show more information...")
            case "Dismiss":
                print("user dismissed the notification 😭")
            case "Later":
//                scheduleLocal(delaySeconds: 3600*1)
                print("Postponed by 1 hour.")
            default:
                break
            }
        }
        completionHandler()
    }
    
}
