//
//  SplashScreenView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var scale = 0.8
    @State private var opacity = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "globe.americas.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .scaleEffect(scale)

                Text(NSLocalizedString("splash.title", comment: "Splash Screen App Title"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.8))
                    .opacity(opacity)

                Text(NSLocalizedString("splash.subtitle", comment: "Splash Screen Subtitle"))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                scale = 1.0
                opacity = 1.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                coordinator.hideSplashScreen()
            }
        }
    }
}

#Preview {
    let coordinator = AppCoordinator()
    
    SplashScreenView()
        .environmentObject(coordinator)
}
