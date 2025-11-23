import Foundation

public class BundleResources: @unchecked Sendable {
    public let bundleURL: URL

    // Bundle.module.bundleURL
    public init(bundleURL: URL) {
        self.bundleURL = bundleURL
    }

    public var resourcesDirectory: URL {
        bundleURL
            .appendingPathComponent("Contents")
            .appendingPathComponent("Resources")
    }

    /// Look in the bundle for the file name requested
    public func resource(named name: String) -> URL {
        resourcesDirectory.appendingPathComponent(name)
    }
}
