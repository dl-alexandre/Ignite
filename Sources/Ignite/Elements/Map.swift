//
// Map.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation

/// Embeds a MapKit JS map.
public struct Map: BlockElement, LazyLoadable {
    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// How many columns this should occupy when placed in a section.
    public var columnWidth = ColumnWidth.automatic

    /// The URL for the MapKit JS map.
    let url: String

    /// A title that describes this content.
    let title: String

    /// Creates a new `Map` instance from the title and URL provided.
    /// - Parameters:
    ///   - title: A title suitable for screen readers.
    ///   - url: The URL to embed on your page.
    public init(title: String, url: URL) {
        self.url = url.absoluteString
        self.title = title
    }

    /// Creates a new `Map` instance from the title and URL provided.
    /// - Parameters:
    ///   - title: A title suitable for screen readers.
    ///   - url: The URL to embed on your page.
    public init(title: String, url: String) {
        self.url = url
        self.title = title
    }

    /// Renders this element using the publishing context passed in.
    /// - Parameter context: The current publishing context.
    /// - Returns: The HTML for this element.
    public func render(context: PublishingContext) -> String {
        // Permissions for the iframe.
        let allowPermissions = """
            accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share
            """

        if attributes.classes.contains("ratio") == false {
            context.addWarning("""
            Embedding \(url) without an aspect ratio will cause it to appear very small. \
            It is recommended to use aspectRatio() so it can scale automatically.
            """)
        }

        return Group {
            #"<iframe src="\#(url)" title="\#(title)" allow="\#(allowPermissions)" style="width: 100%; height: 100%; border: none;"></iframe>"#
        }
        .attributes(attributes)
        .render(context: context)
    }
}
