import SwiftUI

struct HomeScreen: View {
    @ObservedObject var motionManager: MotionManager
    @ObservedObject var voiceCoach: VoiceCoach
    var onStartSession: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("WalkForm AI")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        
                        Text("リアルタイム歩行姿勢コーチ")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Theme.accentCyan)
                    }
                    Spacer()
                    
                    Text("PRO")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Theme.accentGold)
                        .clipShape(Capsule())
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Main Score Hero Card
                VStack(spacing: 16) {
                    Text("本日の歩行クオリティ")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Theme.textSecondary)
                    
                    ZStack {
                        Circle()
                            .stroke(Theme.cardBorder, lineWidth: 14)
                            .frame(width: 170, height: 170)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(motionManager.metrics.score) / 100.0)
                            .stroke(Theme.cyanGradient, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 170, height: 170)
                        
                        VStack(spacing: 2) {
                            Text("姿勢スコア")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Theme.textSecondary)
                            
                            Text("\(motionManager.metrics.score)")
                                .font(.system(size: 52, weight: .heavy))
                                .foregroundColor(Theme.textPrimary)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 10))
                                Text("姿勢年齢 \(motionManager.metrics.postureAgeDiff)歳")
                                    .font(.system(size: 12, weight: .bold))
                            }
                            .foregroundColor(Theme.accentGreen)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Theme.accentGreen.opacity(0.15))
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.vertical, 8)
                    
                    Text("体幹が安定し、美しい歩行姿勢を維持できています")
                        .font(.system(size: 13))
                        .foregroundColor(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Theme.cardDark)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Metrics 3-Card Grid
                HStack(spacing: 12) {
                    // Cadence
                    MetricMiniCard(
                        title: "ケイデンス",
                        value: "\(motionManager.metrics.cadence)",
                        unit: "SPM",
                        icon: "metronome",
                        color: Theme.accentCyan
                    )
                    
                    // Balance
                    MetricMiniCard(
                        title: "骨盤バランス",
                        value: "\(motionManager.metrics.leftBalance):\(motionManager.metrics.rightBalance)",
                        unit: "L / R",
                        icon: "scalemass",
                        color: Theme.accentGreen
                    )
                    
                    // Stride
                    MetricMiniCard(
                        title: "推定歩幅",
                        value: String(format: "%.1f", motionManager.metrics.strideLengthCm),
                        unit: "cm",
                        icon: "figure.walk",
                        color: Theme.accentPurple
                    )
                }
                .padding(.horizontal)
                
                // Voice Coach Preview Banner
                HStack(spacing: 14) {
                    Image(systemName: "waveform.badge.mic")
                        .font(.system(size: 26))
                        .foregroundColor(Theme.accentCyan)
                        .frame(width: 48, height: 48)
                        .background(Theme.accentCyan.opacity(0.15))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("AIリアルタイム音声コーチ")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Theme.accentCyan)
                        Text("「\(voiceCoach.lastSpokenMessage)」")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        voiceCoach.speakAdvice()
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(Theme.accentCyan)
                            .padding(10)
                            .background(Theme.cardBorder)
                            .clipShape(Circle())
                    }
                }
                .padding(16)
                .background(Theme.cardDark)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Start Button CTA
                Button(action: onStartSession) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 20, weight: .bold))
                        Text("歩行測定をスタート")
                            .font(.system(size: 17, weight: .bold))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Theme.cyanGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Theme.accentCyan.opacity(0.4), radius: 10, y: 4)
                }
                .padding(.horizontal)
                .padding(.top, 4)
                .padding(.bottom, 30)
            }
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
    }
}

struct MetricMiniCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Theme.textSecondary)
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                Text(unit)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(Theme.textMuted)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Theme.cardDark)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
}
