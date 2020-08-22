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
            
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Receiver")
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        ContentView()
            .previewDevice(.iPhoneX)
    }
}
