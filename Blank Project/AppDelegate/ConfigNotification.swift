//
//  ConfigNotification.swift
//  Wellmeshi
//
//  Created by PhuongVNC on 2016/11/24.
//  Copyright © 2016 Vo Nguyen Chi Phuong. All rights reserved.
//

import UIKit
import UserNotifications

let kDeviceToken = "kDeviceToken"

extension AppDelegate {

    func registerForRemoteNotifications() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil {
                    kApplication.registerForRemoteNotifications()
                }
            }
        } else {
            let types: UIUserNotificationType = [.badge, .sound, .alert]
            let settings = UIUserNotificationSettings(types: types, categories: nil)
            kApplication.registerUserNotificationSettings(settings)
            kApplication.registerForRemoteNotifications()
        }
    }

    func unregisterForRemoteNotifications() {
        kApplication.unregisterForRemoteNotifications()
    }

    func isRegisteredForRemoteNotifications() -> Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to get token, error: \(error)")
        kUserDefault.removeObject(forKey: kDeviceToken)
        kUserDefault.synchronize()
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject: AnyObject]) {
    }

    func clearLocalPushNotification() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let newToken = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        if let oldToken = kUserDefault.object(forKey: kDeviceToken) as? String {
            if oldToken != newToken {
                postToken(token: newToken)
            }
        } else {
            postToken(token: newToken)
        }
        kUserDefault.set(newToken, forKey: kDeviceToken)
        kUserDefault.synchronize()
    }

    func postToken(token: String) {


    }

    // Handler notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        handlerNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func  handlerNotification(_ userInfo: [AnyHashable: Any]) {

    }

}

@available(iOS 10.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completion: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        handlerNotification(userInfo)

        completion([.alert,.sound,.badge])
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handlerNotification(userInfo)
        completionHandler()
    }
}
