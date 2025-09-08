//
//  PlanetDetailView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Planet Name: \(planet.name)")
                .font(.title2)
                .bold()
            
            Text("Orbital Period: \(planet.orbitalPeriod)")
                .font(.body)
            
            Text("Gravity: \(planet.gravity)")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    PlanetDetailView()
//}
