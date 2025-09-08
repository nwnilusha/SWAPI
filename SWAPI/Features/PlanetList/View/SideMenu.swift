//
//  SideMenu.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct SideMenu: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Image(systemName: "gearshape")
                Text(NSLocalizedString("menu.settings", comment: "Settings menu item"))
            }
            .font(.headline)
            .onTapGesture {
                withAnimation { showMenu = false }
                coordinator.push(.Settings)
            }
            .accessibilityIdentifier("SideMenu_SettingsButton")
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity)
        .background(Color(.systemGray6))
        .ignoresSafeArea(edges: .bottom)
        .accessibilityIdentifier("SideMenu_Container")
    }
}

#Preview {
    SideMenu(showMenu: .constant(true))
}
