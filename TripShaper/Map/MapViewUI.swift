/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import MapKit

struct MapViewUI: UIViewRepresentable {
    
    
    @Binding var region: MKCoordinateRegion
    @Binding var selectedLocation: Location?
    
    let places: [Location]
    let mapViewType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.mapType = mapViewType
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = false
        mapView.addAnnotations(places)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.mapType = mapViewType
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(view: self)
    }
    
}

final class MapCoordinator: NSObject, MKMapViewDelegate {
    
    private var parentView: MapViewUI
    
    init(view: MapViewUI) {
        self.parentView = view
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        switch annotation {
        case let cluster as MKClusterAnnotation:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
            annotationView.markerTintColor = .brown
            for clusterAnnotation in cluster.memberAnnotations {
                if let place = clusterAnnotation as? Location {
                    if place.sponsored {
                        cluster.title = place.name
                        break
                    }
                }
            }
            annotationView.titleVisibility = .visible
            return annotationView
        case let placeAnnotation as Location:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "InterestingPlace") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Interesting Place")
            annotationView.canShowCallout = true
            annotationView.glyphImage = UIImage(systemName: placeAnnotation.icon)
            annotationView.clusteringIdentifier = "cluster"
            annotationView.markerTintColor = UIColor(red: 0.71, green: 0.22, blue: 0.22, alpha: 1.00)
            annotationView.titleVisibility = .visible
//                annotationView.detailCalloutAccessoryView = UIImage(systemName: placeAnnotation.icon).map(UIImageView.init)
            let tapGesture = CustomTapGestureRecognizer(target: self,
                                                        action: #selector(tapSelector(sender:)))
            tapGesture.selectedLocation = placeAnnotation
            annotationView.addGestureRecognizer(tapGesture)
            

            return annotationView
        default: return nil
        }
    }
    
    
    @objc
    func tapSelector(sender: CustomTapGestureRecognizer) {
        parentView.selectedLocation = sender.selectedLocation
    }
    
    
}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var selectedLocation: Location?
}

