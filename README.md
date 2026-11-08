# WalkForm AI (iOS)

WalkForm AI 歩行姿勢コーチのiOS版プロジェクトです。
GitHub Actionsにより、プッシュ時に自動でXcodeプロジェクト生成からTestFlightへのビルド・配信が行われます。

## 構成
- **言語 / UI**: Swift 5, SwiftUI (iOS 16.0+)
- **センサー解析**: CoreMotion (CMPedometer, CMMotionManager)
- **音声ガイダンス**: AVFoundation (AVSpeechSynthesizer)
- **CI/CD**: GitHub Actions (macos-14) + xcodegen + fastlane
