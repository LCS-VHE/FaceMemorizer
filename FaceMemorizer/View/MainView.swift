//
//  ContentView.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import SwiftUI



struct MainView: View {
    @ObservedObject var allData:AllData
    
    var body: some View {
        NavigationView()
        {    
            VStack{
                NavigationLink(destination: level1View(allData: allData), label: {Text("Level One")})
                NavigationLink(destination: level2View(), label: {Text("Level Two")})
            }
                .navigationBarTitle("Face Memorizer")
        }
    }
}
