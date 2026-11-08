import SwiftUI

struct PremiumScreen: View {
    var onReturnHome: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Crown Gold Hero
                VStack(spacing: 12) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 54))
                        .foregroundColor(Theme.accentGold)
                        .padding(.top, 24)
                    
                    Text("WalkForm VIP")
                        .font(.system(size: 28, weight: .heavy))
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("完全公開記念・全機能アンロック中")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Theme.accentGold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Theme.accentGold.opacity(0.15))
                        .clipShape(Capsule())
                }
                
                // VIP Status Card
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Theme.accentGreen)
                        Text("全プレミアム機能がアクティブです")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        Spacer()
                    }
                    
                    Divider().background(Theme.cardBorder)
                    
                    VStack(spacing: 14) {
                        FeatureRow(icon: "waveform.badge.mic", title: "AI日本語リアルタイム音声コーチ", desc: "歩行中のフォーム乱れを即座に声でフィードバック")
                        FeatureRow(icon: "figure.walk.motion", title: "骨盤・歩幅3次元バイオメカニクス解析", desc: "CoreMotion高精度センサーによる微細な重心計測")
                        FeatureRow(icon: "sparkles", title: "姿勢年齢・若見えスコア診断", desc: "ケイデンス・歩幅比率から若々しさを数値化")
                        FeatureRow(icon: "list.bullet.rectangle", title: "全4種類の科学的歩行プログラム", desc: "姿勢改善・速歩・シニア健康・デスクワーカーリセット")
                    }
                }
                .padding(20)
                .background(Theme.cardDark)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Home return CTA
                Button(action: onReturnHome) {
                    Text("ホームに戻って測定する")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Theme.cyanGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let desc: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Theme.accentCyan)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                Text(desc)
                    .font(.system(size: 12))
                    .foregroundColor(Theme.textSecondary)
            }
            Spacer()
        }
    }
}
