//
//  BundleExtention.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

extension Bundle {
    
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }
    
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
}
