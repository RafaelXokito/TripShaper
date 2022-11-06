//
//  ContentView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 04/11/2022.
//

import SwiftUI

final class Photo: Identifiable {
    var image: UIImage
    var location: Location
    
    init(image: UIImage, location: Location) {
        self.image = image
        self.location = location
    }
}

class Photos: ObservableObject {
    @Published var photos: [Photo] = []
}

struct ProgressBar: View {
    @State var currentProgress: CGFloat = 0.0
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.blue)
                .frame(width: 300*currentProgress, height: 20)
        }
    }
}



struct ContentView: View {
    
    @StateObject var photos: Photos = Photos()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    VStack {
                        Spacer(minLength: 200)
                        MapView(location: MapDirectory().places[0],places: MapDirectory().places)
                            .environmentObject(photos)
                        //        Text(String(photos.photos.count)+"/"+String(MapDirectory().places.count))
                        //        ProgressBar(currentProgress: CGFloat(photos.photos.count/MapDirectory().places.count))
                        //            .padding()
                            .frame(height: UIScreen.main.bounds.height - 200)
                        
                        if photos.photos.count > 0{
                            HStack(spacing: 20) {
                                PhotosView()
                                    .environmentObject(photos)
                            }
                            .padding(.top, 20)
                        }
                    }
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                    VStack {
                        ZStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(.background)
                                    .frame(height: 250)
                                
                                VStack {
                                    HStack {
                                        Text("Hi Geekathon,")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Where do you wanna go?")
                                            .font(.title)
                                            .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)) : Color(UIColor(red: 0.04, green: 0.15, blue: 0.33, alpha: 1.00)))
                                        Spacer()
                                    }
                                }
                                .padding(40)
                                .multilineTextAlignment(.center)
                            }
                        }
                        Spacer()
                    }
                    .shadow(radius: 10)
                }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
