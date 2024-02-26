//
//  AppModel.swift
//  xttp
//
//  Created by Wender on 26/02/24.
//

import Foundation

class AppModel: ObservableObject {
    @Published var addNewAction: Bool = false
    @Published var runAction: Bool = false
    @Published var cleanAction: Bool = false
    @Published var duplicateAction: Bool = false
    @Published var renameAction: Bool = false
    @Published var deleteAction: Bool = false
}
