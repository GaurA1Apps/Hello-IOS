import SwiftUI
import CodeEditor

struct AdvancedCodeEditorView: View {
    @State private var source = "// Write your Swift code here\nlet a = 42"
    @State private var language = CodeEditor.Language.swift
    @State private var theme = CodeEditor.ThemeName.pojoaque

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Picker("Language", selection: $language) {
                    ForEach(CodeEditor.availableLanguages) { language in
                        Text("\(language.rawValue.capitalized)")
                            .tag(language)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)

                Picker("Theme", selection: $theme) {
                    ForEach(CodeEditor.availableThemes) { theme in
                        Text("\(theme.rawValue.capitalized)")
                            .tag(theme)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Divider()

            CodeEditor(
                source: $source,
                language: language,
                theme: theme
            )
            .frame(minHeight: 300)
            .cornerRadius(12)
            .padding()
        }
        .navigationTitle("Code Editor")
        .navigationBarTitleDisplayMode(.inline)
    }
} 
