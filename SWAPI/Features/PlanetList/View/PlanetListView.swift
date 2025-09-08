//
//  PlanetListView.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

struct PlanetListView: View {
    
    @StateObject var viewModel: PlanetListViewModel = PlanetListViewModel(service: Service(httpService: HTTPService()))
    
    var body: some View {
        VStack {
            List(viewModel.planets, id: \.self) { planet in
                Text(planet.name)
            }
        }
        .task {
            await viewModel.fetchPlanetData()
        }
    }
}

#Preview {
    PlanetListView()
}
