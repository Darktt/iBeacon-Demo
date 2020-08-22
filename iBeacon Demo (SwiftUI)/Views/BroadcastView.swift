//
//  BroadcastView.swift
//  iBeacon Demo (SwiftUI)
//
//  Created by Darktt on 20/08/22.
//  Copyright © 2020 Darktt. All rights reserved.
//

import SwiftUI

public struct BroadcastView: View
{
    @State
    private var titleText: String = "Not Broadcast"
    
    @State
    private var buttonText: String = "Start boardcast"
    
    @State
    private var isBroadcasting: Bool = false
    
    @State
    private var isPresentAlert: Bool = false
    
    @ObservedObject
    private var broadcaster: Broadcaster = .init()
    
    public var body: some View {
        
        HStack(alignment: .center) {
            
            Spacer()
            
            VStack {
                
                Spacer().frame(height: 120.0)
                
                Text(self.titleText)
                    .font(.system(size: 17.0))
                    .foregroundColor(.titleText)
                
                Spacer()
                
                Button(action: self.buttonAction) {
                    
                    Text(self.buttonText)
                        .font(.system(size: 18.0, weight: .bold, design: .default))
                        .foregroundColor(self.buttonTextColor)
                }.alert(isPresented: self.$isPresentAlert, content: self.alertContent)
                
                Spacer()
            }
            
            Spacer()
        }
        .background(self.backgroundColor)
        .fillScreen()
    }
}

// MARK: - Private Methods -

fileprivate extension BroadcastView
{
    var backgroundColor: some View {
        
        self.isBroadcasting ? Color.blue : Color.broadcastBackgroud
    }
    
    var buttonTextColor: Color {
        
        self.isBroadcasting ? Color.white : Color.blue
    }
    
    var alertTitleText: Text {
        
        var title: String = ""
        
        switch self.broadcaster.state {
            
        case .resetting:
            title = "Resetting"
            
        case .unsupported:
            title = "Unsupported"
            
        case .unauthorized:
            title = "Unauthorized"
            
        case .poweredOff:
            title = "Bluetooth OFF"
            
        default:
            break
        }
        
        return Text(title)
    }
    
    // MARK: - Methods -
    
    func buttonAction() {
        
        withAnimation(.easeInOut(duration: 0.25)) {
            
            self.isBroadcasting.toggle()
        }
        
        self.titleText = self.isBroadcasting ? "Broadcasting..." : "Not Broadcast"
        self.buttonText = self.isBroadcasting ? "Stop boardcast" : "Start boardcast"
        
        self.isPresentAlert = (self.broadcaster.state != .poweredOn)
        self.isBroadcasting ? self.broadcaster.startBroadcast() : self.broadcaster.stopBroadcast()
    }
    
    func alertContent() -> Alert {
        
        let titleText: Text = self.alertTitleText
        let cancelButton = Alert.Button.cancel(self.buttonAction)
        
        let alert = Alert(title: titleText, message: nil, dismissButton: cancelButton)
        
        return alert
    }
}

struct BroadcastView_Previews: PreviewProvider
{
    static var previews: some View {
        
        BroadcastView()
    }
}
