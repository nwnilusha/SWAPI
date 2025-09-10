//
//  PlanetListView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct PlanetListView: View {
    
    @StateObject private var viewModel: PlanetListViewModel
    @State private var showMenu = false
    @State private var showNetworkAlert = false
    @State private var showErrorAlert = false
    
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @Environment(\.dismiss) private var dismiss

    private let sideMenuWidth: CGFloat = 220
    
    init(viewModel: PlanetListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            headerView
            
            SearchBar(
                text: $viewModel.searchedText,
                placeholder: NSLocalizedString("planetlist.search.placeholder", comment: "Search bar placeholder")
            )
            .padding(.horizontal)
            .accessibilityIdentifier("PlanetList_SearchBar")
            
            contentView
        }
        .navigationDestination(for: Planet.self) { planet in
            PlanetDetailView(planet: planet)
        }
        .task {
            await viewModel.fetchPlanetData()
        }
        .onChange(of: networkMonitor.isConnected) { _, isConnected in
            if isConnected {
                Task { await viewModel.fetchPlanetData() }
            }
        }
        .onChange(of: viewModel.errorMessage) { _, newValue in
            showErrorAlert = newValue != nil
        }
        .errorAlert(
            title: NSLocalizedString("planetlist.error", comment: "Error alert title"),
            message: viewModel.errorMessage,
            isPresented: $showErrorAlert
        ) {
            viewModel.errorMessage = nil
        }
    }
    
    private var headerView: some View {
        ZStack {
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        showMenu.toggle()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .imageScale(.large)
                        .padding(.horizontal, 8)
                }
                .accessibilityIdentifier("PlanetList_MenuButton")
                
                Spacer()
            }
            
            Text(NSLocalizedString("planetlist.title", comment: "Planet List title"))
                .font(.title2).bold()
                .accessibilityIdentifier("PlanetList_Title")
        }
        .frame(height: 56)
        .padding(.horizontal)
    }
    
    private var contentView: some View {
        ZStack(alignment: .leading) {
            if showMenu {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) { showMenu = false }
                    }
                    .accessibilityIdentifier("PlanetList_Backdrop")
            }
            
            if showMenu {
                SideMenu(showMenu: $showMenu)
                    .frame(width: sideMenuWidth)
                    .transition(.move(edge: .leading))
            }
            
            if !networkMonitor.isConnected && viewModel.planets.isEmpty {
                NoNetworkView()
                    .offset(x: showMenu ? sideMenuWidth : 0)
                    .accessibilityIdentifier("PlanetList_NoNetworkView")
            } else {
                planetList
                    .offset(x: showMenu ? sideMenuWidth : 0)
                    .disabled(showMenu)
                    .animation(.easeInOut, value: showMenu)
            }
        }
    }
    
    private var planetList: some View {
        List(viewModel.filteredPlanets, id: \.self) { planet in
            NavigationLink(value: planet) {
                PlanetItemView(planet: planet)
                    .accessibilityIdentifier("PlanetList_Row_\(planet.name)")
            }
        }
        .listStyle(.plain)
        .refreshable {
            if networkMonitor.isConnected {
                await viewModel.fetchPlanetData(forceRefresh: true)
            } else {
                showNetworkAlert = true
            }
        }
    }
}

private extension View {
    func errorAlert(title: String, message: String?, isPresented: Binding<Bool>, onDismiss: @escaping () -> Void) -> some View {
        alert(
            title,
            isPresented: isPresented
        ) {
            Button(NSLocalizedString("planetlist.ok", comment: "OK button"), role: .cancel) {
                onDismiss()
            }
        } message: {
            Text(message ?? NSLocalizedString("planetlist.unknownError", comment: "Unknown error message"))
        }
    }
}

#Preview {
    let viewModel = PlanetListViewModel(service: MockService(), cache: MockCache())
    let networkMonitor = NetworkMonitor()
    let coordinator = AppCoordinator()
    
    PlanetListView(viewModel: viewModel)
        .environmentObject(networkMonitor)
        .environmentObject(coordinator)
}
