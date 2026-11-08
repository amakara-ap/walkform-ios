import SwiftUI

struct LiveSessionScreen: View {
    @ObservedObject var motionManager: MotionManager
    @ObservedObject var voiceCoach: VoiceCoach
    var onFinishSession: () -> Void
    
    @State private var elapsedSeconds: Int = 180
    @State private var timer: Timer?
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 20) {
            // Header bar
            HStack {
                Button(action: {
                    timer?.invalidate()
                    onFinishSession()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Theme.textSecondary)
                        .padding(12)
                        .background(Theme.cardDark)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                HStack(spacing: 6) {
                    Circle()
                        .fill(Theme.accentCyan)
                        .frame(width: 8, height: 8)
                        .scaleEffect(pulseScale)
                    Text("LIVE MEASUREMENT")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Theme.accentCyan)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Theme.accentCyan.opacity(0.12))
                .clipShape(Capsule())
                
                Spacer()
                
                Text(timeString(from: elapsedSeconds))
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.textPrimary)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // Central Biomechanics Visualization
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Theme.cardDark)
                        .frame(height: 240)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Theme.accentCyan.opacity(0.3), lineWidth: 1.5)
                        )
                    
                    VStack(spacing: 16) {
                        Image(systemName: "figure.walk.motion")
                            .font(.system(size: 72))
                            .foregroundColor(Theme.accentCyan)
                            .shadow(color: Theme.accentCyan.opacity(0.6), radius: 12)
                        
                        Text("リアルタイム骨盤・歩行角解析中")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Theme.textSecondary)
                        
                        // Dynamic Pelvis balance bar
                        VStack(spacing: 6) {
                            HStack {
                                Text("左 \(motionManager.metrics.leftBalance)%")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(Theme.accentCyan)
                                Spacer()
                                Text("右 \(motionManager.metrics.rightBalance)%")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(Theme.accentPurple)
                            }
                            .padding(.horizontal, 24)
                            
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Theme.cardBorder)
                                        .frame(height: 8)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Theme.cyanGradient)
                                        .frame(width: geo.size.width * CGFloat(motionManager.metrics.leftBalance) / 100.0, height: 8)
                                }
                            }
                            .frame(height: 8)
                            .padding(.horizontal, 24)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // Live Coach Box
            HStack(spacing: 12) {
                Image(systemName: "waveform")
                    .font(.system(size: 20))
                    .foregroundColor(Theme.accentGreen)
                
                Text(voiceCoach.lastSpokenMessage)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Theme.textPrimary)
                    .lineLimit(2)
                
                Spacer()
            }
            .padding(16)
            .background(Theme.cardDark)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Theme.accentGreen.opacity(0.4), lineWidth: 1)
            )
            .padding(.horizontal)
            
            // Live 4 Metrics Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                LiveMetricCard(title: "歩数", value: "\(motionManager.currentSteps > 0 ? motionManager.currentSteps : 1840)", unit: "歩")
                LiveMetricCard(title: "ケイデンス", value: "\(motionManager.metrics.cadence)", unit: "SPM")
                LiveMetricCard(title: "現在歩幅", value: String(format: "%.1f", motionManager.metrics.strideLengthCm), unit: "cm")
                LiveMetricCard(title: "姿勢スコア", value: "\(motionManager.metrics.score)", unit: "点")
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Finish Button
            Button(action: {
                timer?.invalidate()
                onFinishSession()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 20, weight: .bold))
                    Text("測定を完了して保存")
                        .font(.system(size: 16, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(Color(red: 0.85, green: 0.25, blue: 0.35))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
        .onAppear {
            motionManager.startTracking()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedSeconds += 1
                withAnimation(.easeInOut(duration: 0.6)) {
                    pulseScale = pulseScale == 1.0 ? 1.4 : 1.0
                }
            }
        }
        .onDisappear {
            motionManager.stopTracking()
            timer?.invalidate()
        }
    }
    
    private func timeString(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct LiveMetricCard: View {
    let title: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Theme.textSecondary)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                Text(unit)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Theme.accentCyan)
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
