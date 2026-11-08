import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    @StateObject private var voiceCoach = VoiceCoach()
    @State private var selectedTab: Int = 0
    @State private var isLiveSessionActive: Bool = false
    
    var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                HomeScreen(
                    motionManager: motionManager,
                    voiceCoach: voiceCoach,
                    onStartSession: {
                        isLiveSessionActive = true
                    }
                )
                .tabItem {
                    Label("ホーム", systemImage: "figure.walk")
                }
                .tag(0)
                
                ProgramsScreen(
                    onSelectProgram: { _ in
                        isLiveSessionActive = true
                    }
                )
                .tabItem {
                    Label("コース", systemImage: "flame.fill")
                }
                .tag(1)
                
                HistoryScreen()
                    .tabItem {
                        Label("履歴・若見え", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(2)
                
                ProfileScreen()
                    .tabItem {
                        Label("設定", systemImage: "gearshape.fill")
                    }
                    .tag(3)
                
                PremiumScreen(
                    onReturnHome: {
                        selectedTab = 0
                    }
                )
                .tabItem {
                    Label("PRO", systemImage: "crown.fill")
                }
                .tag(4)
            }
            .tint(Theme.accentCyan)
        }
        .fullScreenCover(isPresented: $isLiveSessionActive) {
            LiveSessionScreen(
                motionManager: motionManager,
                voiceCoach: voiceCoach,
                onFinishSession: {
                    isLiveSessionActive = false
                }
            )
        }
    }
}
