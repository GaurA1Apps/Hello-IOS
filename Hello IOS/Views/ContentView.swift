import SwiftUI

struct ContentView: View {
    @StateObject private var preferences = UserPreferences()
    @State private var searchText = ""
    @State private var selectedSkillLevel: SkillLevel? = nil
    @State private var showingDailyTip = true
    
    private var filteredTopics: [Topic] {
        Topic.sampleTopics.filter { topic in
            let matchesSearch = searchText.isEmpty || 
                topic.title.localizedCaseInsensitiveContains(searchText) ||
                topic.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesSkillLevel = selectedSkillLevel == nil || topic.skillLevel == selectedSkillLevel
            
            return matchesSearch && matchesSkillLevel
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search topics...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Skill Level Filters
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterChip(
                                title: "All Levels",
                                icon: "star.fill",
                                isSelected: selectedSkillLevel == nil,
                                color: .blue
                            ) {
                                selectedSkillLevel = nil
                            }
                            
                            ForEach(SkillLevel.allCases, id: \.self) { level in
                                FilterChip(
                                    title: level.rawValue,
                                    icon: level.icon,
                                    isSelected: selectedSkillLevel == level,
                                    color: level.color
                                ) {
                                    selectedSkillLevel = level
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Topics List
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredTopics) { topic in
                                NavigationLink(destination: TopicDetailView(topic: topic)) {
                                    TopicCard(topic: topic, preferences: preferences)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Daily Tip
                    if showingDailyTip {
                        VStack(spacing: 8) {
                            HStack {
                                Text("💡 Daily Tip")
                                    .font(.headline)
                                Spacer()
                                Button(action: { showingDailyTip = false }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Text("Practice makes perfect! Try to complete at least one lesson each day.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Hello iOS")
        }
    }
}

struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                Text(title)
                    .font(.system(size: 15, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? color.opacity(0.2) : Color(.systemGray6))
            .foregroundColor(isSelected ? color : .primary)
            .cornerRadius(20)
        }
    }
}

struct TopicCard: View {
    let topic: Topic
    @ObservedObject var preferences: UserPreferences
    
    private var isCompleted: Bool {
        preferences.isTopicCompleted(topic.id.uuidString)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Image(systemName: topic.icon)
                    .font(.system(size: 24))
                    .foregroundColor(topic.skillLevel.color)
                    .frame(width: 40, height: 40)
                    .background(topic.skillLevel.color.opacity(0.1))
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(topic.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(topic.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer(minLength: 0)
                
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }
            
            HStack {
                Label("\(topic.lessons.count) Lessons", systemImage: "book.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(topic.skillLevel.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(topic.skillLevel.color.opacity(0.1))
                    .foregroundColor(topic.skillLevel.color)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct TopicDetailView: View {
    let topic: Topic
    @StateObject private var preferences = UserPreferences()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: topic.icon)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 60)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(topic.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(topic.skillLevel.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom)
                
                Text(topic.description)
                    .font(.body)
                
                ForEach(topic.lessons) { lesson in
                    NavigationLink(destination: LessonView(lesson: lesson)) {
                        LessonCard(lesson: lesson)
                    }
                }
                
                if !topic.externalLinks.isEmpty {
                    Text("Additional Resources")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(topic.externalLinks.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Link(destination: URL(string: value)!) {
                            HStack {
                                Text(key)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    preferences.toggleBookmark(for: topic.id.uuidString)
                }) {
                    Image(systemName: preferences.isTopicBookmarked(topic.id.uuidString) ? "bookmark.fill" : "bookmark")
                        .foregroundColor(preferences.isTopicBookmarked(topic.id.uuidString) ? .blue : .secondary)
                }
            }
        }
    }
}

struct LessonCard: View {
    let lesson: Lesson
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(lesson.title)
                .font(.headline)
            
            Text(lesson.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Label("\(lesson.codeSamples.count) Code Samples", systemImage: "doc.text")
                Spacer()
                Label("\(lesson.tips.count) Tips", systemImage: "lightbulb")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
    }
} 