//
//  HapticFeedback.swift
//  Carter
//
//  Created by Ahmed Mgua on 25/06/2022.
//

import SwiftUI

enum HapticFeedback {
    static func play(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(notification)
    }
}
