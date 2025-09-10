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
        ScrollView {
            VStack(spacing: 20) {

                Text(planet.name)
                    .font(.largeTitle.bold())
                    .padding(.top)

                section(title: NSLocalizedString("planetdetail.overview", comment: ""), rows: [
                    (NSLocalizedString("planetdetail.climate", comment: ""), planet.climate),
                    (NSLocalizedString("planetdetail.gravity", comment: ""), planet.gravity),
                    (NSLocalizedString("planetdetail.population", comment: ""), planet.population)
                ])
                .accessibilityIdentifier("PlanetDetail_Overview_\(planet.name)")
 
                section(title: NSLocalizedString("planetdetail.physical", comment: ""), rows: [
                    (NSLocalizedString("planetdetail.rotationPeriod", comment: ""), planet.rotationPeriod),
                    (NSLocalizedString("planetdetail.orbitalPeriod", comment: ""), planet.orbitalPeriod),
                    (NSLocalizedString("planetdetail.diameter", comment: ""), planet.diameter),
                    (NSLocalizedString("planetdetail.surfaceWater", comment: ""), planet.surfaceWater),
                    (NSLocalizedString("planetdetail.terrain", comment: ""), planet.terrain)
                ])
                .accessibilityIdentifier("PlanetDetail_Physical_\(planet.name)")

                section(title: NSLocalizedString("planetdetail.metadata", comment: ""), rows: [
                    (NSLocalizedString("planetdetail.created", comment: ""), planet.created),
                    (NSLocalizedString("planetdetail.edited", comment: ""), planet.edited)
                ])
                .accessibilityIdentifier("PlanetDetail_Metadata_\(planet.name)")
            }
            .padding()
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func section(title: String, rows: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)
            
            VStack(spacing: 6) {
                ForEach(rows, id: \.0) { row in
                    HStack {
                        Text(row.0)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(row.1)
                            .font(.subheadline.bold())
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}


#Preview {
    PlanetDetailView(planet: Planet.mockPlanet)
}
