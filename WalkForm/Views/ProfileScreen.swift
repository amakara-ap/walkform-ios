import SwiftUI

struct ProfileScreen: View {
    @State private var height: Double = 162.0
    @State private var weight: Double = 54.0
    @State private var voiceCoachEnabled: Bool = true
    @State private var vibrationFeedback: Bool = true
    
    var idealStrideCm: Double {
        height * 0.40
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("身体設定・アプリ設定")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                    Text("正確な歩幅とカロリー計算のために設定してください")
                        .font(.system(size: 13))
                        .foregroundColor(Theme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Physical Settings Card
                VStack(spacing: 16) {
                    HStack {
                        Text("身体プロフィール")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        Spacer()
                    }
                    
                    // Height Stepper
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("身長")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Theme.textSecondary)
                            Text("\(Int(height)) cm")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Theme.textPrimary)
                        }
                        Spacer()
                        Stepper("", value: $height, in: 130...210, step: 1)
                            .labelsHidden()
                    }
                    
                    Divider().background(Theme.cardBorder)
                    
                    // Ideal Stride Output Banner
                    HStack(spacing: 12) {
                        Image(systemName: "ruler.fill")
                            .foregroundColor(Theme.accentCyan)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("科学的理想歩幅 (身長の40%)")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(Theme.textSecondary)
                            Text(String(format: "%.1f cm", idealStrideCm))
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Theme.accentCyan)
                        }
                        Spacer()
                    }
                    .padding(12)
                    .background(Theme.accentCyan.opacity(0.1))
                    .cornerRadius(12)
                    
                    Divider().background(Theme.cardBorder)
                    
                    // Weight Stepper
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("体重")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Theme.textSecondary)
                            Text("\(Int(weight)) kg")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Theme.textPrimary)
                        }
                        Spacer()
                        Stepper("", value: $weight, in: 35...150, step: 1)
                            .labelsHidden()
                    }
                }
                .padding(18)
                .background(Theme.cardDark)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Coaching & Feedback Settings
                VStack(spacing: 14) {
                    HStack {
                        Text("コーチング設定")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        Spacer()
                    }
                    
                    Toggle(isOn: $voiceCoachEnabled) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("AIリアルタイム音声ガイダンス")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Theme.textPrimary)
                            Text("歩行中に姿勢改善アドバイスを日本語で発話")
                                .font(.system(size: 12))
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .tint(Theme.accentCyan)
                    
                    Divider().background(Theme.cardBorder)
                    
                    Toggle(isOn: $vibrationFeedback) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("姿勢乱れ時の振動アラート")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Theme.textPrimary)
                            Text("骨盤のブレが大きくなった際にバイブレーションで通知")
                                .font(.system(size: 12))
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .tint(Theme.accentCyan)
                }
                .padding(18)
                .background(Theme.cardDark)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // App Information & Links
                VStack(spacing: 12) {
                    HStack {
                        Text("アプリバージョン")
                            .font(.system(size: 13))
                            .foregroundColor(Theme.textSecondary)
                        Spacer()
                        Text("1.0.0 (Build 1)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    
                    Divider().background(Theme.cardBorder)
                    
                    Link(destination: URL(string: "https://sites.google.com/view/walkform-ai?usp=sharing")!) {
                        HStack {
                            Text("プライバシーポリシー")
                                .font(.system(size: 13))
                                .foregroundColor(Theme.textPrimary)
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .font(.system(size: 13))
                                .foregroundColor(Theme.accentCyan)
                        }
                    }
                }
                .padding(18)
                .background(Theme.cardDark)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                Spacer(minLength: 30)
            }
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
    }
}
