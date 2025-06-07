import Foundation
import SwiftUI

struct CodeSample: Identifiable {
    let id = UUID()
    let title: String
    let code: String
    let explanation: String
}

struct Quiz: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let explanation: String
}

struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let codeSamples: [CodeSample]
    let tips: [String]
    let quiz: Quiz
}

enum TopicCategory: String, Codable {
    case ui = "UI"
    case data = "Data"
    case advanced = "Advanced"
}

struct Topic: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let category: TopicCategory
    let skillLevel: SkillLevel
    let lessons: [Lesson]
    let externalLinks: [String: String]
}

// Sample data
extension Topic {
    static let sampleTopics: [Topic] = [
        Topic(
            title: "Swift Basics",
            description: "Learn the fundamentals of Swift programming language",
            icon: "swift",
            category: TopicCategory.data,
            skillLevel: SkillLevel.beginner,
            lessons: [
                Lesson(
                    title: "Variables and Constants",
                    content: "Learn about variables and constants in Swift.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic Variables",
                            code: "var name = \"John\"\nlet age = 25",
                            explanation: "This shows how to declare variables and constants in Swift."
                        )
                    ],
                    tips: [
                        "Use let for values that won't change",
                        "Use var for values that will change",
                        "Always use meaningful variable names"
                    ],
                    quiz: Quiz(
                        question: "Which keyword is used for constants in Swift?",
                        options: ["var", "let", "const", "final"],
                        correctAnswerIndex: 1,
                        explanation: "The 'let' keyword is used to declare constants in Swift."
                    )
                )
            ],
            externalLinks: [
                "Swift Documentation": "https://docs.swift.org/swift-book/"
            ]
        ),
        
        Topic(
            title: "SwiftUI Basics",
            description: "Create beautiful user interfaces with SwiftUI",
            icon: "rectangle.3.group.bubble.left.fill",
            category: TopicCategory.ui,
            skillLevel: SkillLevel.beginner,
            lessons: [
                Lesson(
                    title: "Creating Your First View",
                    content: "Learn how to create and customize views in SwiftUI.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic View",
                            code: "struct ContentView: View {\n    var body: some View {\n        Text(\"Hello, World!\")\n    }\n}",
                            explanation: "This shows how to create a basic SwiftUI view."
                        )
                    ],
                    tips: [
                        "Use the preview canvas to see your changes in real-time",
                        "Views are structs that conform to the View protocol",
                        "The body property must return a single view"
                    ],
                    quiz: Quiz(
                        question: "What protocol must a SwiftUI view conform to?",
                        options: ["UIView", "View", "ViewController", "UIViewController"],
                        correctAnswerIndex: 1,
                        explanation: "SwiftUI views must conform to the View protocol."
                    )
                )
            ],
            externalLinks: [
                "SwiftUI Documentation": "https://developer.apple.com/documentation/swiftui"
            ]
        ),
        
        Topic(
            title: "Networking in iOS",
            description: "Learn how to make network requests and handle API responses",
            icon: "globe.badge.chevron.backward",
            category: TopicCategory.data,
            skillLevel: SkillLevel.intermediate,
            lessons: [
                Lesson(
                    title: "URLSession Basics",
                    content: "Learn how to make network requests using URLSession and handle responses.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic Network Request",
                            code: "let url = URL(string: \"https://api.example.com/data\")!\nlet task = URLSession.shared.dataTask(with: url) { data, response, error in\n    // Handle response\n}\ntask.resume()",
                            explanation: "This shows how to create and execute a basic network request."
                        )
                    ],
                    tips: [
                        "Always handle errors and response status codes",
                        "Use async/await for modern networking code",
                        "Consider using URLSession's shared instance for simple requests"
                    ],
                    quiz: Quiz(
                        question: "Which class is used for making network requests in iOS?",
                        options: ["NetworkManager", "URLSession", "HTTPClient", "APIClient"],
                        correctAnswerIndex: 1,
                        explanation: "URLSession is the primary class for making network requests in iOS."
                    )
                )
            ],
            externalLinks: [
                "URLSession Documentation": "https://developer.apple.com/documentation/foundation/urlsession"
            ]
        ),
        
        Topic(
            title: "Core Data Mastery",
            description: "Advanced data persistence and relationships",
            icon: "externaldrive.connected.to.line.below",
            category: TopicCategory.data,
            skillLevel: SkillLevel.intermediate,
            lessons: [
                Lesson(
                    title: "Core Data Relationships",
                    content: "Learn how to create and manage relationships between entities in Core Data.",
                    codeSamples: [
                        CodeSample(
                            title: "Entity Relationship",
                            code: "// In Core Data model editor:\n// User entity has many Posts\n// Post entity belongs to one User\n\nlet user = User(context: context)\nlet post = Post(context: context)\npost.user = user\nuser.posts?.adding(post)",
                            explanation: "This shows how to set up relationships between Core Data entities."
                        )
                    ],
                    tips: [
                        "Use inverse relationships for data consistency",
                        "Consider using NSPredicate for complex queries",
                        "Always perform Core Data operations on the correct context"
                    ],
                    quiz: Quiz(
                        question: "What is the purpose of inverse relationships in Core Data?",
                        options: ["Performance", "Data Consistency", "Memory Management", "Query Optimization"],
                        correctAnswerIndex: 1,
                        explanation: "Inverse relationships help maintain data consistency in Core Data."
                    )
                )
            ],
            externalLinks: [
                "Core Data Documentation": "https://developer.apple.com/documentation/coredata"
            ]
        ),
        
        Topic(
            title: "SwiftUI Navigation",
            description: "Master navigation patterns in SwiftUI",
            icon: "arrow.triangle.branch",
            category: TopicCategory.ui,
            skillLevel: SkillLevel.intermediate,
            lessons: [
                Lesson(
                    title: "Navigation Stack",
                    content: "Learn how to implement navigation in SwiftUI using NavigationStack and NavigationLink.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic Navigation",
                            code: "NavigationStack {\n    NavigationLink(\"Go to Detail\") {\n        DetailView()\n    }\n}",
                            explanation: "This shows how to create a basic navigation setup in SwiftUI."
                        )
                    ],
                    tips: [
                        "Use NavigationStack for iOS 16+",
                        "Consider using NavigationSplitView for iPad apps",
                        "Handle deep links with navigation state"
                    ],
                    quiz: Quiz(
                        question: "Which view is used for navigation in iOS 16+?",
                        options: ["NavigationView", "NavigationStack", "NavigationController", "UINavigationController"],
                        correctAnswerIndex: 1,
                        explanation: "NavigationStack is the new navigation container in iOS 16+."
                    )
                )
            ],
            externalLinks: [
                "SwiftUI Navigation": "https://developer.apple.com/documentation/swiftui/navigation"
            ]
        ),
        
        Topic(
            title: "Dependency Injection",
            description: "Learn how to implement clean architecture with DI",
            icon: "arrow.triangle.2.circlepath",
            category: TopicCategory.advanced,
            skillLevel: SkillLevel.intermediate,
            lessons: [
                Lesson(
                    title: "Protocol-Based DI",
                    content: "Learn how to implement dependency injection using protocols in Swift.",
                    codeSamples: [
                        CodeSample(
                            title: "Protocol-Based Service",
                            code: "protocol NetworkService {\n    func fetchData() async throws -> Data\n}\n\nclass APIClient: NetworkService {\n    func fetchData() async throws -> Data {\n        // Implementation\n    }\n}",
                            explanation: "This shows how to create a protocol-based service for dependency injection."
                        )
                    ],
                    tips: [
                        "Use protocols for better testability",
                        "Consider using a DI container for complex apps",
                        "Keep dependencies explicit and minimal"
                    ],
                    quiz: Quiz(
                        question: "What is the main benefit of using protocols for dependency injection?",
                        options: ["Performance", "Testability", "Memory Management", "Code Size"],
                        correctAnswerIndex: 1,
                        explanation: "Protocols make it easier to test code by allowing mock implementations."
                    )
                )
            ],
            externalLinks: [
                "Swift Protocols": "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols"
            ]
        ),
        Topic(
            title: "Combine Framework",
            description: "Master reactive programming with Combine",
            icon: "arrow.triangle.merge",
            category: TopicCategory.advanced,
            skillLevel: SkillLevel.advanced,
            lessons: [
                Lesson(
                    title: "Publishers and Subscribers",
                    content: "Learn about the core concepts of Combine framework: Publishers, Subscribers, and Operators.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic Publisher",
                            code: "let publisher = Just(5)\npublisher.sink { value in\n    print(value)\n}",
                            explanation: "This demonstrates how to create and subscribe to a simple publisher."
                        )
                    ],
                    tips: [
                        "Always store cancellables to prevent memory leaks",
                        "Use operators to transform and combine publishers"
                    ],
                    quiz: Quiz(
                        question: "Which protocol defines the output type in Combine?",
                        options: ["Publisher", "Subscriber", "Cancellable", "Operator"],
                        correctAnswerIndex: 0,
                        explanation: "The Publisher protocol defines the output type of a stream."
                    )
                )
            ],
            externalLinks: [
                "Combine Documentation": "https://developer.apple.com/documentation/combine"
            ]
        ),
        Topic(
            title: "Swift Concurrency",
            description: "Modern concurrency in Swift",
            icon: "clock.arrow.2.circlepath",
            category: TopicCategory.advanced,
            skillLevel: SkillLevel.advanced,
            lessons: [
                Lesson(
                    title: "Async/Await",
                    content: "Learn about modern concurrency in Swift using async/await.",
                    codeSamples: [
                        CodeSample(
                            title: "Async Function",
                            code: "func fetchData() async throws -> Data {\n    let (data, _) = try await URLSession.shared.data(from: url)\n    return data\n}",
                            explanation: "This shows how to create an async function that fetches data."
                        )
                    ],
                    tips: [
                        "Use async/await instead of completion handlers",
                        "Always handle errors with try-catch"
                    ],
                    quiz: Quiz(
                        question: "Which keyword is used to call an async function?",
                        options: ["sync", "await", "async", "wait"],
                        correctAnswerIndex: 1,
                        explanation: "The await keyword is used to call async functions."
                    )
                )
            ],
            externalLinks: [
                "Swift Concurrency": "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency"
            ]
        ),
        Topic(
            title: "Advanced Animations in SwiftUI",
            description: "Create stunning animations using SwiftUI",
            icon: "sparkles.tv.fill",
            category: TopicCategory.ui,
            skillLevel: SkillLevel.advanced,
            lessons: [
                Lesson(
                    title: "Custom Animations",
                    content: "Learn how to create custom and interactive animations in SwiftUI.",
                    codeSamples: [
                        CodeSample(
                            title: "Spring Animation",
                            code: "withAnimation(.spring()) {\n    isExpanded.toggle()\n}",
                            explanation: "This shows how to use a spring animation in SwiftUI."
                        )
                    ],
                    tips: [
                        "Use implicit and explicit animations for different effects",
                        "Combine transitions and animations for advanced UI"
                    ],
                    quiz: Quiz(
                        question: "Which modifier is used to animate changes in SwiftUI?",
                        options: [".transition", ".animation", ".withAnimation", ".move"],
                        correctAnswerIndex: 2,
                        explanation: ".withAnimation is used to animate state changes."
                    )
                )
            ],
            externalLinks: [
                "SwiftUI Animations": "https://developer.apple.com/documentation/swiftui/animation"
            ]
        ),
        Topic(
            title: "App Architecture",
            description: "Explore MVVM and Clean Architecture in iOS apps",
            icon: "building.columns.fill",
            category: TopicCategory.advanced,
            skillLevel: SkillLevel.advanced,
            lessons: [
                Lesson(
                    title: "MVVM Pattern",
                    content: "Learn about the Model-View-ViewModel pattern and how to implement it in SwiftUI.",
                    codeSamples: [
                        CodeSample(
                            title: "Basic MVVM",
                            code: "class ViewModel: ObservableObject {\n    @Published var text = \"Hello\"\n}\nstruct ContentView: View {\n    @StateObject var vm = ViewModel()\n    var body: some View {\n        Text(vm.text)\n    }\n}",
                            explanation: "This shows a simple MVVM setup in SwiftUI."
                        )
                    ],
                    tips: [
                        "Keep business logic in the ViewModel",
                        "Use ObservableObject and @Published for state management"
                    ],
                    quiz: Quiz(
                        question: "What does MVVM stand for?",
                        options: ["Model-View-ViewModel", "Model-View-Mediator", "Model-View-Mock", "Model-View-Middleware"],
                        correctAnswerIndex: 0,
                        explanation: "MVVM stands for Model-View-ViewModel."
                    )
                )
            ],
            externalLinks: [
                "MVVM in SwiftUI": "https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app"
            ]
        ),
        Topic(
            title: "Unit & UI Testing",
            description: "Write robust tests for your iOS apps",
            icon: "checkmark.shield.fill",
            category: TopicCategory.advanced,
            skillLevel: SkillLevel.advanced,
            lessons: [
                Lesson(
                    title: "Unit Testing Basics",
                    content: "Learn how to write and run unit tests in Xcode.",
                    codeSamples: [
                        CodeSample(
                            title: "Simple Test Case",
                            code: "func testAddition() {\n    XCTAssertEqual(2 + 2, 4)\n}",
                            explanation: "This shows a basic unit test in XCTest."
                        )
                    ],
                    tips: [
                        "Test small units of logic",
                        "Use XCTAssert functions for validation"
                    ],
                    quiz: Quiz(
                        question: "Which framework is used for unit testing in iOS?",
                        options: ["Quick", "Nimble", "XCTest", "TestKit"],
                        correctAnswerIndex: 2,
                        explanation: "XCTest is the standard framework for unit testing in iOS."
                    )
                )
            ],
            externalLinks: [
                "Testing with XCTest": "https://developer.apple.com/documentation/xctest"
            ]
        )
    ]
} 
