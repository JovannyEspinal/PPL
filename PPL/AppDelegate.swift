//
//  AppDelegate.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navController = window?.rootViewController as! UINavigationController
        let workoutController = navController.viewControllers[0] as! WorkoutListViewController
        
        if let pastWorkouts = UserDefaults.standard.object(forKey: "PastWorkouts") as? [String:Any] {
            let workouts = WorkoutFactory.workouts(from: pastWorkouts)
            
            WorkoutManager.manager.pastWorkouts = workouts.pastWorkouts
            WorkoutManager.manager.currentWorkout = workouts.currentWorkout
        }
        
        WorkoutManager.manager.currentWorkout = WorkoutFactory.createWorkout()
        
        let dataProvider = WorkoutListDataProvider()
        workoutController.dataProvider = dataProvider
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 8/255.0, green: 74/255.0, blue: 131/255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.removeObject(forKey: "startDate")
        UserDefaults.standard.synchronize()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleNotification(after seconds: TimeInterval){
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Time's up!"
        content.body = "Start your next set."
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: timeIntervalTrigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("We had an error: \(error)")
            }
        }
    }
    
    
}

