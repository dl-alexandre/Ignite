//
// ListItem.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation

/// Creates one item in a list. This isn't always needed, because you can place other
/// elements directly into lists if you wish. Use `ListItem` when you specifically
/// need a styled HTML <li> element.
public struct ListItem: HTML {
    /// The content and behavior of this HTML.
    public var body: some HTML { self }

    /// The content of this list item.
    var content: any InlineElement

    /// Creates a new `ListItem` object using an inline element builder that
    /// returns an array of `HTML` objects to display in the list.
    /// - Parameter items: The content you want to display in your list.
    public init(@InlineElementBuilder content: () -> some InlineElement) {
        self.content = content()
    }

    /// Renders this element using publishing context passed in.
    /// - Parameter context: The current publishing context.
    /// - Returns: The HTML for this element.
    public func render(context: PublishingContext) -> String {
        "<li\(attributes.description)>\(content.render(context: context))</li>"
    }
}
