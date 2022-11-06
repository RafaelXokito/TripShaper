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
import AlertToast

struct DetailMapView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var location: Location
    @State private var showToast = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            KFImage(URL(string: location.imageURL)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(30)
                            //                        .aspectRatio(contentMode: .fit)
//                                .fade(duration: 0.25)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.main.bounds.width-60, height: 200)
//                                .cornerRadius(30)
                        }
                        .frame(height: 200)
                        
                        Text(location.name)
                            .font(.system(size: 34, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)) : Color(UIColor(red: 0.04, green: 0.15, blue: 0.33, alpha: 1.00)))
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
                            Text("Rating: " + String(location.rating))
                            Spacer()
                        }
                        .padding(.bottom)
                        if location.accessibility {
                            HStack {
                                Image(systemName: "figure.roll")
                                    .font(.system(size: 35))
                                    .foregroundColor(.red)
                                Text("Accessible")
                                Spacer()
                            }
                            .padding(.bottom)
                        }
                        HStack {
                            Image(systemName: "ruler")
                                .font(.system(size: 35))
                                .foregroundColor(.red)
                            Text("Range to receive rewards (m): " + String(location.rangeMeters))
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        Text(location.details)
                        Spacer()
                    }
                    .padding(30)
                    .toast(isPresenting: $showToast){
                        
                        // `.alert` is the default displayMode
                        AlertToast(type: .systemImage("exclamationmark.triangle", .yellow), title: "Reach closer of " + location.name + "!")
                        
                        //Choose .hud to toast alert from the top of the screen
                        //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
                        
                        //Choose .banner to slide/pop alert from the bottom of the screen
                        //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
                    }
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
                                    .frame(width: 20, height: 20)
                                    .padding(25)
                                    .foregroundColor(.black)
                            }
                            NavigationLink(destination: CameraView(location: location)) {
                                Button(action: {
                                    if (Int(calcDistance() - Double(location.rangeMeters)) > 0) {
                                        showToast.toggle()
                                    }
                                }) {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                    if (Int(calcDistance() - Double(location.rangeMeters)) > 0) {
                                        Text(String(Int(calcDistance() - Double(location.rangeMeters))) + " m")
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.trailing,25)
                                .disabled(Int(calcDistance() - Double(location.rangeMeters)) <= 0)
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
            }
        }
    
    func calcDistance() -> Double {
        let point1 = MKMapPoint(MapViewModel().region.center)
        let point2 = MKMapPoint(self.location.location.coordinate)
        let distance = point1.distance(to: point2)
        return distance
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
