import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @StateObject private var preferences = UserPreferences()
    @State private var selectedSkillLevel: SkillLevel = .beginner
    @State private var showSkillLevelPicker = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .symbolEffect(.bounce, options: .repeating)
                
                Text("Ready to Master iOS Development?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Whether you're just starting your journey or looking to level up your skills, we've got you covered. Let's begin your path to becoming an iOS developer!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .foregroundColor(.secondary)
                
                VStack(spacing: 16) {
                    Text("Select your skill level:")
                        .font(.headline)
                    
                    Picker("Skill Level", selection: $selectedSkillLevel) {
                        ForEach(SkillLevel.allCases, id: \.self) { level in
                            Text(level.rawValue)
                                .tag(level)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 32)
                }
                .padding(.vertical)
                
                Spacer()
                
                Button(action: {
                    preferences.skillLevel = selectedSkillLevel
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                }) {
                    Text("Start Learning")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
} 