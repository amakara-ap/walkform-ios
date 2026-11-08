import SwiftUI

struct ProgramsScreen: View {
    var onSelectProgram: (WalkProgram) -> Void
    
    let programs: [WalkProgram] = [
        WalkProgram(
            id: "prog_posture",
            title: "姿勢改善・若見え歩行",
            subtitle: "見た目年齢-5歳を目指す美姿勢ウォーク",
            durationWeeks: 2,
            level: "初級〜中級",
            iconName: "figure.walk",
            isUnlocked: true,
            description: "背筋・骨盤のブレを抑え、歩幅を広げることで若々しい歩行フォームを定着させます。"
        ),
        WalkProgram(
            id: "prog_core",
            title: "体幹シェイプ・速歩",
            subtitle: "ケイデンスを高め代謝UPと体幹強化",
            durationWeeks: 4,
            level: "中級",
            iconName: "flame.fill",
            isUnlocked: true,
            description: "170〜180 SPMの速歩をインターバルで行い、インナーマッスルと心肺機能を刺激します。"
        ),
        WalkProgram(
            id: "prog_senior",
            title: "シニア健康ウォーキング",
            subtitle: "すり足・転倒を予防する関節ケア歩行",
            durationWeeks: 8,
            level: "全年齢",
            iconName: "heart.fill",
            isUnlocked: true,
            description: "つま先の引き上げと左右均等な重心移動をマスターし、安全で軽やかな足運びを養います。"
        ),
        WalkProgram(
            id: "prog_pelvis",
            title: "デスクワーカー骨盤リセット",
            subtitle: "座りっぱなしによる骨盤前傾・後傾を整える",
            durationWeeks: 1,
            level: "初級",
            iconName: "arrow.triangle.2.circlepath",
            isUnlocked: true,
            description: "長時間の着席で固まった腸腰筋と臀筋を意識しながら、正しい骨盤ニュートラルで歩きます。"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("AI歩行プログラム")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("科学的エビデンスに基づく目的別トレーニング（全プログラム利用可能）")
                        .font(.system(size: 13))
                        .foregroundColor(Theme.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Programs List
                ForEach(programs) { prog in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: prog.iconName)
                                .font(.system(size: 20))
                                .foregroundColor(Theme.accentCyan)
                                .frame(width: 40, height: 40)
                                .background(Theme.accentCyan.opacity(0.12))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(prog.title)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Theme.textPrimary)
                                Text(prog.subtitle)
                                    .font(.system(size: 12))
                                    .foregroundColor(Theme.textSecondary)
                            }
                            
                            Spacer()
                            
                            Text("解放済")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(Theme.accentGreen)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Theme.accentGreen.opacity(0.15))
                                .clipShape(Capsule())
                        }
                        
                        Text(prog.description)
                            .font(.system(size: 13))
                            .foregroundColor(Theme.textSecondary)
                            .lineSpacing(3)
                        
                        HStack {
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .font(.system(size: 12))
                                Text("\(prog.durationWeeks)週間")
                                    .font(.system(size: 12, weight: .medium))
                            }
                            .foregroundColor(Theme.textMuted)
                            
                            Spacer()
                            
                            Button(action: {
                                onSelectProgram(prog)
                            }) {
                                HStack(spacing: 4) {
                                    Text("プログラムを開始")
                                        .font(.system(size: 13, weight: .bold))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .bold))
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Theme.cyanGradient)
                                .clipShape(Capsule())
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
                }
                
                Spacer(minLength: 30)
            }
        }
        .background(Theme.backgroundDark.ignoresSafeArea())
    }
}
