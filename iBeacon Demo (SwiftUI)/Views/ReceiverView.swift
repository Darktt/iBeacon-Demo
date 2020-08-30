//
//  ReceiverView.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/30.
//  Copyright © 2020 Darktt. All rights reserved.
//

import SwiftUI
import CoreLocation
import SwiftUIPullToRefresh

struct ReceiverView: View
{
    @State
    var beacons: [String] = ReceiverView.generateBeacons(by: 10)
    
    @State
    var showRefreshView: Bool = false
    
    var body: some View {
        
        RefreshableList(showRefreshView: self.$showRefreshView, action: self.refreshAction) {
            
            ForEach(self.beacons, id: \.self, content: {
                
                beacon in
                
                VStack(alignment: .leading) {
                    
                    Text(beacon)
                    Divider()
                }
            })
        }
        .navigationBarTitle("Receiver", displayMode: .inline)
    }
}

// MARK: - Actions -

private extension  ReceiverView
{
    func refreshAction()
    {
        self.beacons = ReceiverView.generateBeacons(by: 20)
        
        Delay(duration: 1.0) {
            self.showRefreshView = false
        }
    }
}

// MARK: - Private Methods -

private extension ReceiverView
{
    static func generateBeacons(by count: Int) -> [String] {
        
        let beacons: [String] = (0 ... count).map {
            
            _ in
            
            "\(Int.random(in: 0 ... 100))"
        }
        
        return beacons
    }
}

// MARK: - Previews -

struct ReceiverView_Previews: PreviewProvider
{
    static var previews: some View {
        
        ReceiverView()
            .previewDevice(.iPhoneX)
    }
}
