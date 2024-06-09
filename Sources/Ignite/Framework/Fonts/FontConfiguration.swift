//
// File.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation

// A simple protocol that lets users create custom font configurations easily.
public protocol FontConfiguration {
    var customFont: [CustomFont] { get }
}
