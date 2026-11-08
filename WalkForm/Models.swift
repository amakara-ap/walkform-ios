import Foundation

struct GaitMetrics: Codable {
    var score: Int = 85
    var cadence: Int = 168        // 歩数/分
    var leftBalance: Int = 51    // 左荷重 %
    var rightBalance: Int = 49   // 右荷重 %
    var strideLengthCm: Double = 64.8 // 歩幅 (cm)
    var stridePercentage: Double = 40.0 // 身長比 %
    var postureAgeDiff: Int = -4 // 姿勢年齢差 (歳)
    var forwardTiltDeg: Double = 2.4 // 前傾角
    var lateralSwayDeg: Double = 1.2 // 骨盤左右ブレ
}

struct WalkSession: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date = Date()
    var durationSeconds: Int = 1240
    var stepCount: Int = 2340
    var averageScore: Int = 86
    var distanceKm: Double = 1.52
    var caloriesKcal: Int = 88
    var targetMet: Bool = true
}

struct WalkProgram: Identifiable {
    var id: String
    var title: String
    var subtitle: String
    var durationWeeks: Int
    var level: String
    var iconName: String
    var isUnlocked: Bool = true
    var description: String
}

struct UserProfile: Codable {
    var heightCm: Double = 162.0
    var weightKg: Double = 54.0
    var targetStrideRatio: Double = 0.40 // 身長の40%が理想歩幅
    var isVoiceCoachEnabled: Bool = true
    var voicePaceSeconds: Int = 30
    var isPremiumActive: Bool = true
    
    var idealStrideCm: Double {
        return heightCm * targetStrideRatio
    }
}
