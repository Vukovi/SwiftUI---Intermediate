//
//  11_ScheduleLocalPushNotifications.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 13.11.23.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "First Notification"
        content.subtitle = "Something here..."
        content.sound = .default
        content.badge = 1
        
        /*
         UNNotificationTrigger -> time, calendar & location
         */
        
        // time notification -> za 5 sekundi je okini
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar notification -> svakog dana u 20:26 okini notifikaciju
        var dateComponent = DateComponents()
        dateComponent.hour = 20
        dateComponent.minute = 26
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // location notification -> svaki put kad user udje u region u okviru 100m ili izadje
        let coordinate = CLLocationCoordinate2D(latitude: 42, longitude: 43)
        let region = CLCircularRegion(
            center: coordinate,
            radius: 100,
            identifier: UUID().uuidString)
        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: timeTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct ScheduleLocalPushNotifications: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.shared.requestAuthorization()
            }
            
            Button("Schedule notification") {
                NotificationManager.shared.scheduleNotification()
            }
            
            Button("Cancel notification") {
                NotificationManager.shared.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }

}

#Preview {
    ScheduleLocalPushNotifications()
}
