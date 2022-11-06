//
//  ContentView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 04/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
        MapView(location: MapDirectory().places[0],places: MapDirectory().places)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
