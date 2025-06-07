import Foundation

class UserPreferences: ObservableObject {
    @Published var skillLevel: SkillLevel = .beginner
    @Published var completedTopics: Set<UUID> = []
    @Published var bookmarkedTopics: Set<UUID> = []
    
    init() {
        loadProgress()
    }
    
    func isTopicCompleted(_ topicId: String) -> Bool {
        guard let uuid = UUID(uuidString: topicId) else { return false }
        return completedTopics.contains(uuid)
    }
    
    func isTopicBookmarked(_ topicId: String) -> Bool {
        guard let uuid = UUID(uuidString: topicId) else { return false }
        return bookmarkedTopics.contains(uuid)
    }
    
    func toggleBookmark(for topicId: String) {
        guard let uuid = UUID(uuidString: topicId) else { return }
        if bookmarkedTopics.contains(uuid) {
            bookmarkedTopics.remove(uuid)
        } else {
            bookmarkedTopics.insert(uuid)
        }
        saveProgress()
    }
    
    func markTopicAsCompleted(_ topicId: String) {
        guard let uuid = UUID(uuidString: topicId) else { return }
        completedTopics.insert(uuid)
        saveProgress()
    }
    
    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(completedTopics) {
            UserDefaults.standard.set(encoded, forKey: "completedTopics")
        }
        if let encoded = try? JSONEncoder().encode(bookmarkedTopics) {
            UserDefaults.standard.set(encoded, forKey: "bookmarkedTopics")
        }
        UserDefaults.standard.set(skillLevel.rawValue, forKey: "skillLevel")
    }
    
    private func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: "completedTopics"),
           let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            completedTopics = decoded
        }
        if let data = UserDefaults.standard.data(forKey: "bookmarkedTopics"),
           let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            bookmarkedTopics = decoded
        }
        if let savedLevel = UserDefaults.standard.string(forKey: "skillLevel"),
           let level = SkillLevel(rawValue: savedLevel) {
            skillLevel = level
        }
    }
} 