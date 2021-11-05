//
//  MapView.swift
//  UserLocationUsingSwiftUI
//
//  Created by Pradeep's Macbook on 05/11/21.
//

import SwiftUI
import MapKit

//14.2214° N, 80.0032° E

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .accentColor(Color.pink)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.checkIfLocationServicesEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewDevice("iPhone 11")
    }
}
