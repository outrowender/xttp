//
//  View.swift
//  xttp
//
//  Created by Wender on 23/02/24.
//

import SwiftUI

extension View {
    func listen(for value: Binding<Bool>, action: @escaping (_ oldValue: Bool, _ newValue: Bool) -> Void) -> some View {
        return self.onChange(of: value.wrappedValue, action)
    }
}
