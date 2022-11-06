//
//  TravelsView.swift
//  TripShaper
//
//  Created by Rafael Pereira on 06/11/2022.
//

import SwiftUI

struct TravelsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var trips: [Travel] = MapDirectory().travels
    
    var body: some View {
        VStack {
            Text("My Trips")
                .font(.system(size: 34, design: .rounded))
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)) : Color(UIColor(red: 0.04, green: 0.15, blue: 0.33, alpha: 1.00)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
            
            ForEach(trips, id: \.id) { travel in
                
                VStack {
                    Text(travel.destination)
                    Text(travel.startDate + " - " + travel.endDate)
                }
                .frame(width: UIScreen.main.bounds.width-60, height: 70, alignment: .center)
                .padding()
                padding(.bottom, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black, lineWidth: 2)
                )
                
            }
            
            Spacer()
            
        }
        .padding()
    }
}

struct TravelsView_Previews: PreviewProvider {
    static var previews: some View {
        TravelsView()
    }
}
