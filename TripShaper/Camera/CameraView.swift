//
//  CameraView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 06/11/2022.
//

import SwiftUI
import Kingfisher

struct CameraView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var location: Location
    
    @EnvironmentObject var photos: Photos
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = true
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(30)
                            .border(Color.black, width: 5)
                            .padding(.all, 50)
                    } else {
                        KFImage(URL(string: location.imageURL)!)
                        //                        .aspectRatio(contentMode: .fit)
                            .fade(duration: 0.25)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width-60, height: 200)
                            .cornerRadius(30)
                            .overlay( /// apply a rounded border
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black, lineWidth: 5)
                            )
//                        KFImage(URL(string: location.imageURL)!)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .border(Color.orange, width: 10)
//                                    .padding(.all, 50)
                            
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            HStack {
                                Button(action: {
                                    self.sourceType = .camera
                                    self.isImagePickerDisplay.toggle()
                                }) {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .padding(20)
                                }
                                .padding(.horizontal, 20)
                                if selectedImage != nil {
                                    Divider()
                                        .frame(height: 30)
                                    Button(action: {
                                        if selectedImage != nil {
                                            UIImageWriteToSavedPhotosAlbum(selectedImage!, nil, nil, nil)
//                                            photos.append(Photo(image: selectedImage!, location: location))
//                                            print(photos.count)
                                            photos.photos.append(Photo(image: selectedImage!, location: location))
                                            photos.photos.forEach { photo in
                                                print(photo.location.name)
                                            }
//                                            print(photos.photos[photos.photos.count-1].image)
//                                            print(photos.photos.count)
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                        
                                    }) {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .padding(20)
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .background(.white)
                            .foregroundColor(.black)
                            .cornerRadius(.infinity)
                            .padding()
                            .padding(.bottom, 20)
                            .shadow(radius: 10)
                            
                            Spacer()
                            
                        }
                    }
                }
                

                
//                Button("Camera") {
//                    self.sourceType = .camera
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
//
//                Button("Photo") {
//                    self.sourceType = .photoLibrary
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
            }
            .navigationBarTitle(location.name)
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
        }
    }
}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView(location: MapDirectory().places[0], photos: <#Binding<[Photo]>#>)
//    }
//}
