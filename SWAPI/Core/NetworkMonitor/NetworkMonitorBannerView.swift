//
//  NetworkMonitorBannerView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct NetworkMonitorBannerView: View {
    let bannerType: BannerType

    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Image(systemName: bannerType == .connected ? "wifi" : "wifi.slash")
                Text(bannerType == .connected ? "Internet Connection Restored" : "No Internet Connection")
                    .bold()
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(bannerType == .connected ? Color.green : Color.red)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 40)
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.easeInOut, value: bannerType)
            
            Spacer()
        }
        .zIndex(1)
    }
}

#Preview {
    NetworkMonitorBannerView(bannerType: BannerType.disconnected)
}
