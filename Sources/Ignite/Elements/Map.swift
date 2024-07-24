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
        let mapScript = """
        <div id="map" style="width: 100%; height: 400px;"></div>
        <script>
        mapkit.init({
            authorizationCallback: function(done) {
                done('YOUR_JWT_TOKEN');
            }
        });
        
        var map = new mapkit.Map("map");
        var coordinate = new mapkit.Coordinate(37.7749, -122.4194); // Example coordinates (San Francisco)
        var annotation = new mapkit.MarkerAnnotation(coordinate, { title: "\(title)" });
        map.showItems([annotation]);
        </script>
        """
        
        return Group {
            Script(code: mapScript).render(context: context)
        }
        .attributes(attributes)
        .render(context: context)
    }
}

/*

 
 func test_attributes() {
     let element = Script(file: "/code.js")
         .data("key", "value")
         .addCustomAttribute(name: "custom", value: "part")
     let output = element.render(context: publishingContext)

     XCTAssertEqual(output, "<script custom=\"part\" data-key=\"value\" src=\"/code.js\"></script>")
 }
 
<iframe src="https://embed.apple-mapkit.com/v1/place?place=I2FEB0F2FB4D7B0EE&token=eyJraWQiOiJSNzgzRjNIOE05IiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiIyTVA4UVdLN1I2IiwiaWF0IjoxNzIxODU1OTU0LCJleHAiOjE3MjI0OTU1OTl9.ViD505SG9QW54fv5h3iv9lQsY328OlHF-1mEPdFeNzRmqrRI137IaXlGXr2W5lR9brWG7Luej1SoEyr8beXsjw" width="580" height="580" frameborder="0"></iframe>


<script src="https://cdn.apple-mapkit.com/mk/5.x.x/mapkit.core.js"
    crossorigin async
    data-callback="initMapKit"
    data-libraries="map"
    data-token="IMPORTANT: ADD YOUR TOKEN HERE">
</script>

<script type="module">
// Wait for MapKit JS to be ready to use.
const setupMapKitJs = async() => {
    // If MapKit JS is not yet loaded...
    if (!window.mapkit || window.mapkit.loadedLibraries.length === 0) {
        // ...await <script>'s data-callback (window.initMapKit).
        await new Promise(resolve => { window.initMapKit = resolve });
        // Clean up.
        delete window.initMapKit;
    }
};

/**
 * Script Entry Point
 */
const main = async() => {
    await setupMapKitJs();

    const cupertino = new mapkit.CoordinateRegion(
        new mapkit.Coordinate(37.3316850890998, -122.030067374026),
        new mapkit.CoordinateSpan(0.167647972, 0.354985255)
    );

    // Create a map in the element whose ID is "map-container".
    const map = new mapkit.Map("map-container");
    map.region = cupertino;
};

main();
 
*/
