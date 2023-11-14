//
//  10_Haptics & Vibrations.swift
//  SwiftUI-Intermediate
//
//  Created by Vuk Knezevic on 13.11.23.
//

import SwiftUI

// MARK: - Haptics je isto sto i vibracije

class HapticsManager {
    static let shared = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct Haptics___Vibrations: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Button notification success") {
                HapticsManager.shared.notification(type: .success)
            }
            
            Button("Button notification warning") {
                HapticsManager.shared.notification(type: .warning)
            }
            
            Button("Button notification error") {
                HapticsManager.shared.notification(type: .error)
            }
            
            Divider()
            
            Button("Button impact soft") {
                HapticsManager.shared.impact(style: .soft)
            }
            
            Button("Button impact light") {
                HapticsManager.shared.impact(style: .light)
            }
            
            Button("Button impact medium") {
                HapticsManager.shared.impact(style: .medium)
            }
            
            Button("Button impact heavy") {
                HapticsManager.shared.impact(style: .heavy)
            }
            
            Button("Button impact rigid") {
                HapticsManager.shared.impact(style: .rigid)
            }
        }
    }
}

#Preview {
    Haptics___Vibrations()
}
