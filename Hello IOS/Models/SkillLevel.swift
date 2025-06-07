import Foundation
import SwiftUI

enum SkillLevel: String, CaseIterable, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var color: Color {
        switch self {
        case .beginner:
            return .green
        case .intermediate:
            return .orange
        case .advanced:
            return .purple
        }
    }
    
    var icon: String {
        switch self {
        case .beginner:
            return "leaf.fill"
        case .intermediate:
            return "bolt.fill"
        case .advanced:
            return "star.fill"
        }
    }
} 