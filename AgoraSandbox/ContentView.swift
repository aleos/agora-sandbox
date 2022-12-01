//
//  ContentView.swift
//  AgoraSandbox
//
//  Created by Alexander Ostrovsky on 01.12.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LiveView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.green, width: 2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
