//
//  FaceMemorizerApp.swift
//  FaceMemorizer
//
//  Created by Vincent He on 2022-11-03.
//

import SwiftUI

@main
struct FaceMemorizerApp: App {
    @StateObject var globalData:AllData = AllData()
    
    var body: some Scene {
        WindowGroup {
            TabView
            {
                MainView(allData: globalData)
                    .tabItem{
                        Label("Home", systemImage: "tray.and.arrow.down.fill")
                    }
                
                MakerView()
                    .tabItem{
                        Label("Maker", systemImage: "tray.and.arrow.down.fill")
                    }
                
                ErrorView(allData: globalData)
                    .tabItem{
                        Label("Wrong Answers", systemImage: "tray.and.arrow.down.fill")
                    }    
            }
        }
    }
}
