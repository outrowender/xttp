//
//  View.swift
//  xttp
//
//  Created by Wender on 23/02/24.
//

import Foundation
import SwiftUI

struct GlassEffect: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
    func updateNSView(_ nsView: NSView, context: Context) { }
}




extension View {
    func listen(for value: Binding<Bool>, action: @escaping (() -> Void)) -> some View {
        return self.onChange(of: value.wrappedValue) { oldValue, newValue in
            action()
        }
    }
}
