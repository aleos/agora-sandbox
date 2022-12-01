//
//  LiveView.swift
//  AgoraSandbox
//
//  Created by Alexander Ostrovsky on 01.12.22.
//

import SwiftUI

struct LiveView: View {
    
    // Track if the local user is in a call
    var joined: Bool = false
    
    
    var body: some View {
        Button(joined ? "Leave" : "Join", action: buttonAction)
            .buttonStyle(.borderedProminent)
    }
    
    func joinChannel() -> Bool { true }
    func leaveChannel() {}
    
    func buttonAction() {
        if !joined {
            joinChannel()
        } else {
            leaveChannel()
        }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
