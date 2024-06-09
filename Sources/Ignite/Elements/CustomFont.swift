//
// File.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation


public struct CustomFont: InlineElement {
    public var attributes = CoreAttributes()
    
    var familyName: String
    var weight: String
    var style: String
    var path: [String]

    public init(familyName: String, weight: String, style: String, path: [String]) {
        self.familyName = familyName
        self.weight = weight
        self.style = style
        self.path = path
    }

    public init(familyName: String, weight: String, style: String) {
        self.familyName = familyName
        self.weight = weight
        self.style = style
        self.path = ["*"]
    }

//    public init(font: KnownFont, paths: [String]) {
//        self.familyName = font.rawValue
//        self.path = path
//    }
//
//    public init(font: KnownFont) {
//        self.familyName = font.rawValue
//        self.path = ["*"]
//    }
    public func render(context: PublishingContext) -> String {
        return "<styles = font-family: \(familyName); src: url('\(path)'); font-weight: \(weight); font-style: \(style)"
    }
}
