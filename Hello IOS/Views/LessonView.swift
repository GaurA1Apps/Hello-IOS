import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    @StateObject private var preferences = UserPreferences()
    @State private var selectedAnswer: Int?
    @State private var showQuizResult = false
    @State private var isCodeCopied = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(lesson.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(lesson.content)
                    .font(.body)
                
                // Code Samples
                ForEach(lesson.codeSamples) { sample in
                    CodeSampleView(sample: sample, isCopied: $isCodeCopied)
                }
                
                // Tips Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("💡 Tips")
                        .font(.headline)
                    
                    ForEach(lesson.tips, id: \.self) { tip in
                        HStack(alignment: .top) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text(tip)
                        }
                    }
                }
                .padding()
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(12)
                
                // Quiz Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("❓ Quiz")
                        .font(.headline)
                    
                    Text(lesson.quiz.question)
                        .font(.body)
                    
                    ForEach(lesson.quiz.options.indices, id: \.self) { index in
                        Button(action: {
                            selectedAnswer = index
                            showQuizResult = true
                        }) {
                            HStack {
                                Text(lesson.quiz.options[index])
                                Spacer()
                                if selectedAnswer == index {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(selectedAnswer == index ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
                            )
                        }
                        .disabled(showQuizResult)
                    }
                    
                    if showQuizResult {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(selectedAnswer == lesson.quiz.correctAnswerIndex ? "✅ Correct!" : "❌ Incorrect")
                                .font(.headline)
                                .foregroundColor(selectedAnswer == lesson.quiz.correctAnswerIndex ? .green : .red)
                            
                            Text(lesson.quiz.explanation)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct CodeSampleView: View {
    let sample: CodeSample
    @Binding var isCopied: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sample.title)
                .font(.headline)
            
            HStack {
                Text(sample.code)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Button(action: {
                    UIPasteboard.general.string = sample.code
                    withAnimation {
                        isCopied = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isCopied = false
                        }
                    }
                }) {
                    Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc")
                        .foregroundColor(isCopied ? .green : .blue)
                }
            }
            
            Text(sample.explanation)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
} 