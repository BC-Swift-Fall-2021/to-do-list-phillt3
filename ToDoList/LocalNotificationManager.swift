//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Phillip  Tracy on 10/2/21.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    
    static func authorizeLocalNotifications(viewController: UIViewController){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, error)
            in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notifications Authorization Granted!")
            } else {
                print("The user has denied notifications!")
                DispatchQueue.main.async {
                    viewController.oneButtonALert(title: "User Has Not Allowed Notification" , message: "To receive alerts for reminders, open the Settings app, select To Do Lits > Notifications > Allow Notifications")
                }
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool) -> ()){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, error)
            in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notifications Authorization Granted!")
                completed(true)
            } else {
                print("The user has denied notifications!")
                completed(false)
            }
        }
    }
    
    static func setCalendarNotifications(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        //create content
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        
        // register reuqest with notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("ERROR \(error.localizedDescription), adding a notification went wrong!")
                
            } else {
                print("Notification scheduled \(notificationID), title: \(content.title)")
            }
        }
        return notificationID
    }
}
