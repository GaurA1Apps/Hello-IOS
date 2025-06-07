import SwiftUI

@main
struct HelloIOSApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @StateObject private var preferences = UserPreferences()
    
    var body: some Scene {
        WindowGroup {
            if !hasCompletedOnboarding {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
    }
}

struct MainTabView: View {
    @StateObject private var preferences = UserPreferences()
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Learn")
                }
            AdvancedCodeEditorView()
                .tabItem {
                    Image(systemName: "chevron.left.slash.chevron.right")
                    Text("Code Editor")
                }
        }
    }
} 
