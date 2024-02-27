//
//  ViewEffects.swift
//  xttp
//
//  Created by Wender on 27/02/24.
//

import SwiftUI

struct GlassEffect: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}
