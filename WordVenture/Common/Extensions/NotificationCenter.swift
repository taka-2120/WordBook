//
//  NotificationCenter.swift
//  WordBook
//
//  Created by Yu Takahashi on 5/16/23.
//


import Foundation

extension NSNotification.Name {
    static let dismiss = NSNotification.Name.init("dismiss")
    static let showPasswordReset = NSNotification.Name.init("showPasswordReset")
    static let showLessonPrep = NSNotification.Name.init("showLessonPrep")
    static let showLessonMain = NSNotification.Name.init("showLessonMain")
    static let dismissMicPermission = NSNotification.Name.init("dismissMicPermission")
    static let dismissNotificationsPermission = NSNotification.Name.init("dismissNotificationsPermission")
}

extension NotificationCenter {
    func showError() {
        self.post(name: .dismiss, object: nil)
    }
}
