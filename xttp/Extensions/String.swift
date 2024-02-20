//
//  String.swift
//  xttp
//
//  Created by Wender on 20/02/24.
//

import Foundation

extension String {
    static func generate(with size: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<size).map{ _ in letters.randomElement()! })
    }
}
