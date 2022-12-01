//
//  RepresentedUIView.swift
//  AgoraSandbox
//
//  Created by Alexander Ostrovsky on 01.12.22.
//

import SwiftUI

struct RepresentedUIView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    let view: UIView
    
    func makeUIView(context: Context) -> UIView { view }
    func updateUIView(_ uiView: UIView, context: Context) { }
}
