//
//  ThemeManager.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: String { rawValue }

    var title: String {
        switch self { case .system: return "System"; case .light: return "Light"; case .dark: return "Dark" }
    }

    var colorScheme: ColorScheme? {
        switch self { case .system: return nil; case .light: return .light; case .dark: return .dark }
    }
}

class ThemeManager {
    static func currentColorScheme(selectedTheme: String) -> ColorScheme? {
        switch AppTheme(rawValue: selectedTheme) ?? .system {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
