import SwiftUI

enum Theme {
    static let backgroundDark = Color(red: 0.04, green: 0.06, blue: 0.10)
    static let cardDark = Color(red: 0.07, green: 0.10, blue: 0.16)
    static let cardBorder = Color(red: 0.15, green: 0.20, blue: 0.32)
    static let primaryDark = Color(red: 0.08, green: 0.20, blue: 0.38)
    
    static let accentCyan = Color(red: 0.00, green: 0.90, blue: 1.00)
    static let accentGold = Color(red: 1.00, green: 0.84, blue: 0.00)
    static let accentGreen = Color(red: 0.06, green: 0.73, blue: 0.51)
    static let accentPurple = Color(red: 0.65, green: 0.35, blue: 1.00)
    
    static let textPrimary = Color.white
    static let textSecondary = Color(red: 0.58, green: 0.64, blue: 0.72)
    static let textMuted = Color(red: 0.40, green: 0.46, blue: 0.54)
    
    static let cyanGradient = LinearGradient(
        colors: [accentCyan, Color(red: 0.0, green: 0.55, blue: 1.0)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let goldGradient = LinearGradient(
        colors: [accentGold, Color(red: 1.0, green: 0.6, blue: 0.0)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
