//
//  PlanetItemView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct PlanetItemView: View {
    let planet: Planet
    
    var body: some View {
        HStack(spacing: 16) {
            RemoteImageView(url: URL(string: Constants.imageURLString))
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Name: \(planet.name)")
                    .font(.headline)
                Text("Climate: \(planet.climate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct RemoteImageView: View {
    let url: URL?
    
    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    PlanetItemView()
//}
