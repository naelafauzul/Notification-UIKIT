//
//  ViewController.swift
//  Notification-UIKIT
//
//  Created by Naela Fauzul Muna on 03/04/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var notifButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    //setting permission to receive notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, _ in
            if granted {
                print("Obtained permission from the user for local notifications")
            } else {
                print("Did not obtained permission from the user for local notifications")
            }
        }
    }
    
    @IBAction func scheduleNotification(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Let's Continue Saving"
        content.body = "Keep filling your savings to quickly achieve your dreams."
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        let fireDate = Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute, .second],
            from: Date().addingTimeInterval(10)
        )
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        
        //notification request
        let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "An error occurred in the local notification.")")
            }
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("UserInfo about notification == \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}




