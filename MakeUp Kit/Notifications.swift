//
//  Notifications.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 03.06.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import Foundation
import UserNotifications

func sendNotification(title: String, body: String, interval: Int) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
    let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
    notificationCenter.add(request) { (error) in
        print("Error: \(error?.localizedDescription)")
    }
}
