//
//  PhotosView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 06/11/2022.
//

import SwiftUI

struct PhotosView: View {
    
    @EnvironmentObject var photos: Photos
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(photos.photos, id: \.id) { photo in
                    Image(uiImage: photo.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(30)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
//        List(photos.photos) { photo in
//            Text(photo.location.name)
//            Image(uiImage: photo.image)
//                .frame(width: 200, height: 200)
//        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
