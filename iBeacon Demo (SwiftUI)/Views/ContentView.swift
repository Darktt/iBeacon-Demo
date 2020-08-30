//
//  ContentView.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/22.
//  Copyright © 2020 Darktt. All rights reserved.
//

import SwiftUI

public struct ContentView: View
{
    public var body: some View {
        
        TabView {
            
            BroadcastView()
                .tabItem {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("Boradcast")
                }
                .edgesIgnoringSafeArea(.top)
            
            NavigationView {
                
                ReceiverView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "person.3.fill")
                Text("Receiver")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        Group {
            
            ContentView()
                .previewDevice(.iPhoneX)
            
            ContentView()
                .previewDevice(.iPhone7)
            
            ContentView()
            .previewDevice(nil)
        }
    }
}
