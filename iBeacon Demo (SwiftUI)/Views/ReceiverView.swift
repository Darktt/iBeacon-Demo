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
    // MARK: - Properties -
    
    @ObservedObject
    var receiver: Receiver = .init()
    
    @State
    var showRefreshView: Bool = false
    
    var body: some View {
        
        RefreshableList(showRefreshView: self.$showRefreshView, action: self.refreshAction) {
            
            ForEach(self.receiver.beacons, id: \.self, content: {
                
                beacon in
                
                VStack(alignment: .leading) {
                    
                    Text(beacon.uuid.uuidString)
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
        self.receiver.startReceiving()
        
        Delay(duration: 20.0) {
            
            self.showRefreshView = false
            self.receiver.stopReceiving()
        }
    }
}

// MARK: - Private Methods -

private extension ReceiverView
{
    
}

// MARK: - Previews -

struct ReceiverView_Previews: PreviewProvider
{
    static var previews: some View {
        
        ReceiverView()
            .previewDevice(.iPhoneX)
    }
}
