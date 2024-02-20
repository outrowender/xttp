//
//  VerbRequestModelExtensions.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import Foundation
import SwiftUI

extension VerbRequestModel {
    func colored() -> Color {
        
        let result: [VerbRequestModel: Color] = [
            .get: .purple,
            .post: .green,
            .put: .orange,
            .patch: .yellow,
            .delete: .red,
            .options: .blue,
            .head: .blue
        ]
        
        return result[self] ?? .white
    }
}
