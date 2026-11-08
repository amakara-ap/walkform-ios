import SwiftUI

struct HistoryScreen: View {
    let mockSessions: [WalkSession] = [
        WalkSession(date: Date(), durationSeconds: 1420, stepCount: 2680, averageScore: 88, distanceKm: 1.74, caloriesKcal: 98, targetMet: true),
        WalkSession(date: Date().addingTimeInterval(-86400), durationSeconds: 1210, stepCount: 2150, averageScore: 85, distanceKm: 1.40, caloriesKcal: 82, targetMet: true),
        WalkSession(date: Date().addingTimeInterval(-172800), durationSeconds: 1840, stepCount: 3420, averageScore: 86, distanceKm: 2.21, caloriesKcal: 126, targetMet: true),
        WalkSession(date: Date().addingTimeInterval(-259200), durationSeconds: 980, stepCount: 1680, averageScore: 82, distanceKm: 1.10, caloriesKcal: 65, targetMet: false),
        WalkSession(date: Date().addingTimeInterval(-345600), durationSeconds: 1530, stepCount: 2840, averageScore: 87, distanceKm: 1.85, caloriesKcal: 104, targetMet: true)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("歩行履歴・若見え推移")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                    Text("姿勢の改善が若々しい歩行フォームとして定着しています")
                        .font(.system(size: 13))
                        .foregroundColor(Theme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Youthfulness Summary Card
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("推定姿勢年齢")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Theme.textSecondary)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("-4.2")
                                .font(.system(size: 36, weight: .heavy))
                                .foregroundColor(Theme.accentGreen)
                            Text("歳若見え")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Theme.accentGreen)
                        }
                        
                        Text("歩幅とケイデンスの安定が若さの証拠です")
                            .font(.system(size: 11))
                            .foregroundColor(Theme.textSecondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "figure.walk.arrival")
                        .font(.system(size: 44))
                        .foregroundColor(Theme.accentGreen)
                        .padding(14)
                        .background(Theme.accentGreen.opacity(0.12))
                        .clipShape(Circle())
                }
                .padding(18)
                .background(Theme.cardDark)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Weekly Trend Bar Graph
                VStack(alignment: .leading, spacing: 14) {
                    Text("直近のスコア推移")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                    
                    HStack(alignment: .bottom, spacing: 14) {
                        ForEach(mockSessions.reversed()) { sess in
                            VStack(spacing: 6) {
                                Text("\(sess.averageScore)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(Theme.accentCyan)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Theme.cyanGradient)
                                    .frame(width: 32, height: CGFloat(sess.averageScore - 50) * 2.8)
                                
                                Text(shortDateString(from: sess.date))
                                    .font(.system(size: 10))
                                    .foregroundColor(Theme.textMuted)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .bottom)
                    .padding(.vertical, 8)
                }
                .padding(18)
                .background(Theme.cardDark)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Session List Header
                Text("測定セッション履歴")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                // List Items
                ForEach(mockSessions) { sess in
                    HStack(spacing: 14) {
                        VStack(spacing: 2) {
                            Text("\(sess.averageScore)")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Theme.accentCyan)
                            Text("スコア")
                                .font(.system(size: 10))
                                .foregroundColor(Theme.textSecondary)
                        }
                        .frame(width: 52, height: 52)
                        .background(Theme.primaryDark)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(dateString(from: sess.date))
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Theme.textPrimary)
                            
                            HStack(spacing: 12) {
                                Text("\(sess.stepCount) 歩")
                                Text(String(format: "%.2f km", sess.distanceKm))
                                Text("\(sess.durationSeconds / 60) 分")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(Theme.textSecondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12))
                            .foregroundColor(Theme.textMuted)
                    }
                    .padding(14)
                    .background(Theme.cardDark)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Theme.cardBorder, lineWidth: 1)
                    )
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 30)
            }
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
    }
    
    private func dateString(from date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "M月d日(E) HH:mm"
        return df.string(from: date)
    }
    
    private func shortDateString(from date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "M/d"
        return df.string(from: date)
    }
}
