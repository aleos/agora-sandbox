//
//  LiveView.swift
//  AgoraSandbox
//
//  Created by Alexander Ostrovsky on 01.12.22.
//

import SwiftUI

struct LiveView: View {
    
    @StateObject var liveStream: LiveStream = LiveStream()
    
    var body: some View {
        Button(liveStream.joined ? "Leave" : "Join", action: liveStream.buttonAction)
            .buttonStyle(.borderedProminent)
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView()
    }
}
