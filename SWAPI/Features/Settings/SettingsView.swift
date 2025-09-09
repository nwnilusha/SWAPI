//
//  SettingsView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = "system"
    
    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("settings.section.appearance", comment: "Appearance section header"))) {
                Picker(NSLocalizedString("settings.theme", comment: "App theme picker label"), selection: $selectedTheme) {
                    Text(NSLocalizedString("settings.theme.system", comment: "System theme")).tag("system")
                    Text(NSLocalizedString("settings.theme.light", comment: "Light theme")).tag("light")
                    Text(NSLocalizedString("settings.theme.dark", comment: "Dark theme")).tag("dark")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedTheme) { _, newValue in
                }
            }
            
            Section(header: Text(NSLocalizedString("settings.section.about", comment: "About section header"))) {
                HStack {
                    Text(NSLocalizedString("settings.appVersion", comment: "App version label"))
                    Spacer()
                    Text(Bundle.main.appVersion)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text(NSLocalizedString("settings.buildNumber", comment: "Build number label"))
                    Spacer()
                    Text(Bundle.main.buildNumber)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(NSLocalizedString("settings.title", comment: "Settings view title"))
    }
}

#Preview {
    SettingsView()
}
