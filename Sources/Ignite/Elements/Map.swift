//
// Map.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation


///Pick only the interfaces you need to optimize your app load time. MapKit JS divides its interfaces into libraries that you can specify when loading the framework:

enum MapLibrary {
    case map, fullmap, annotations, services, overlays, geojson, userlocation
    
    var libraryString: String {
        switch self {
            /// Basic mapkit.Map features without overlays, annotations, and relevant data types.
            case .map:
                return "map"
            /// All mapkit.Map features and relevant data types.
            case .fullmap:
                return "full-map"
            /// Annotations, data types, and displays on mapkit.Map.
            case .annotations:
                return "annotations"
            /// All services interfaces (such as Search and Geocoder) and relevant data types.
            case .services:
                return "services"
            /// Overlays, data types, and displays on mapkit.Map.
            case .overlays:
                return "overlays"
            /// The GeoJSON importer.
            case .geojson:
                return "geojson"
            /// User location display and controls on mapkit.Map.
            case .userlocation:
                return "user-location"
        }
    }
}

/// Embeds a MapKit JS map.
public struct Map: BlockElement, InlineElement, LazyLoadable {
    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()
    
    /// How many columns this should occupy when placed in a section.
    public var columnWidth = ColumnWidth.automatic
    
    /// Direct, inline JavaScript code to execute.
    private var code: String?
    
    /// The external file to load.
    private var library: MapLibrary?
    
    /// Direct, inline JavaScript code to execute.
    private var token: String?
    
    /// The content to place inside the text.
    
    /// Embeds some custom, inline JavaScript on this page.
    public init() {
       
    }
    
    /// Renders this element using publishing context passed in.
    /// - Parameter context: The current publishing context.
    /// - Returns: The HTML for this element.
    public func render(context: PublishingContext) -> String {
        
        
        
        return Group {
            """
        
        <!DOCTYPE html>
        <html>
        <head>
        
        <meta charset="utf-8">
            
            <style>
                #map-container {
                    width: 100%;
                    height: 600px;
                }
            </style>
        </head>
        
        <body>
        <div id="map-container"></div>
        </body>
        </html>
        
        """
            
            Script(file: "https://cdn.apple-mapkit.com/mk/5.x.x/mapkit.core.js")
                .addCustomAttribute(name: "crossorigin", value: "anonymous")
                .addCustomAttribute(name: "async", value: "async")
                .data("callback", "initMapKit")
                .data("libraries", "map")
                .data("token", "eyJraWQiOiJSNzgzRjNIOE05IiwidHlwIjoiSldUIiwiYWxnIjoiRVMyNTYifQ.eyJpc3MiOiIyTVA4UVdLN1I2IiwiaWF0IjoxNzIxODU1OTU0LCJleHAiOjE3MjI0OTU1OTl9.ViD505SG9QW54fv5h3iv9lQsY328OlHF-1mEPdFeNzRmqrRI137IaXlGXr2W5lR9brWG7Luej1SoEyr8beXsjw")
            
            Script(code:
        """
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
        """
            )
            .addCustomAttribute(name: "type", value: "module")
        }
        .id("map-container")
        .attributes(attributes)
        .render(context: context)
        
//        return output
//        if let file {
//            return "<script\(attributes.description) src=\"\(context.site.url.path)\(file)\"></script>"
//        } else if let code {
//            return "<script\(attributes.description)>\(code)</script>"
//        } else {
//            context.addWarning("""
//            Creating a script with no source or code should not be possible. \
//            Please file a bug report on the Ignite project.
//            """)
//            return ""
//        }
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
