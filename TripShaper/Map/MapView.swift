//
//  MapView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 05/11/2022.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    
    let location: Location
    let places: [Location]

    @StateObject private var viewModel = MapViewModel()
    @State private var selectedPlace: Location?
    
    
    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = .standard
    
    init(location: Location, places: [Location]) {
      self.location = location
      self.places = places
      _region = State(initialValue: location.region)
    }
    
    var body: some View {
        VStack {
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations) { location in
//                    MapAnnotation(coordinate: location.coordinate) {
//                        VStack {
//                            Image(systemName: location.icon)
//                                .resizable()
//                                .foregroundColor(.red)
//                                .frame(width: 44, height: 44)
//                                .background(.white)
//                                .clipShape(Circle())
//                            Text(location.name)
//                        }
//                        .onTapGesture {
//                            selectedPlace = location
//                        }
//                    }
//            }
            MapViewUI(region: $viewModel.region, selectedLocation: $selectedPlace, places: places, mapViewType: .standard)
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationServiceIsEnabled()
            }
        }
        .sheet(item: $selectedPlace) { place in
            DetailMapView(location: place)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: MapDirectory().places[0], places: MapDirectory().places)
    }
}
