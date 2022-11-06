//
//  DetailMapView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 05/11/2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Kingfisher

struct DetailMapView: View {
    
    @State var location: Location
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    KFImage(URL(string: location.imageURL)!)
//                        .aspectRatio(contentMode: .fit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width-60, height: 200)
                        .cornerRadius(25)
                        
                    Text(location.name)
                        .font(.system(size: 34, design: .rounded))
                        .foregroundColor(Color(UIColor(red: 0.04, green: 0.15, blue: 0.33, alpha: 1.00)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 30)
                    HStack {
                        Image(systemName: "trophy.circle")
                            .font(.system(size: 35))
                            .foregroundColor(.red)
                        Text("Points for visiting: " + String(location.rewardPoints))
                        Spacer()
                    }
                    .padding(.bottom)
                    HStack {
                        Image(systemName: "star.circle")
                            .font(.system(size: 35))
                            .foregroundColor(.red)
                        Text("Points for visiting: " + String(location.rating))
                        Spacer()
                    }
                    .padding(.bottom)
                    HStack {
                        Image(systemName: "ruler")
                            .font(.system(size: 35))
                            .foregroundColor(.red)
                        Text("Points for visiting: " + String(location.rangeMeters))
                        Spacer()
                    }
                    .padding(.bottom)
                    Text(location.details)
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                openMaps(location: location)
                            }) {
                                Image(systemName: "map")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .padding(20)
                                    .foregroundColor(.black)
                            }
                            Button(action: {
                                print("tapped saved")
                            }) {
                                Image(systemName: "bookmark")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .padding(20)
                                    .foregroundColor(.black)
                            }
                        }
                        .background(.white)
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                        .padding()
                        .padding(.bottom, 20)
                        .shadow(radius: 10)
                    }
                }
                .frame(minHeight: UIScreen.main.bounds.height-120)
            }
            .padding(30)
        }
    }
}

func openMaps(location: Location) {
    
    let source = MKMapItem(placemark: MKPlacemark(coordinate: MapViewModel().region.center))
    source.name = "Source"
            
    let destination = MKMapItem(placemark: MKPlacemark(coordinate: location.location.coordinate))
    destination.name = location.name
    
    MKMapItem.openMaps(
      with: [source, destination],
      launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    )
}

struct DetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapView(location: MapDirectory().places[0])
    }
}
