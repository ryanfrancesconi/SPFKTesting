import Foundation
@testable import SPFKTesting
import Testing

@Suite("BundleResources")
struct BundleResourcesTests {
    @Test("init stores bundleURL")
    func initStoresBundleURL() {
        let url = Bundle.module.bundleURL
        let br = BundleResources(bundleURL: url)
        #expect(br.bundleURL == url)
    }

    @Test("resourcesDirectory is derived from bundleURL")
    func resourcesDirectoryDerived() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)
        #expect(br.resourcesDirectory.path.hasPrefix(br.bundleURL.path))
    }

    /// Asserts reachability rather than path shape, which is not fixed — Xcode writes
    /// `Contents/Resources` and SwiftPM's CLI build writes a flat bundle. A shape assertion passes
    /// under both while describing a file that exists under only one.
    @Test("resourcesDirectory resolves to the directory the resources are actually in")
    func resourcesDirectoryResolvesToRealFiles() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)

        #expect(FileManager.default.fileExists(atPath: br.resourcesDirectory.path))
        #expect(FileManager.default.fileExists(atPath: br.resource(named: "tabla.wav").path))
    }

    /// Fixture URLs are compared with `==` all over the workspace, and `URL` compares the relative
    /// string plus base rather than the resolved path — so a URL carrying a `baseURL` opens the
    /// right file while comparing unequal to every absolute spelling of it. A `fileExists` check
    /// cannot see this, because `path` resolves the base.
    @Test("resource(named:) returns absolute URLs, comparable with ==")
    func resourceURLsAreAbsolute() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)
        let url = br.resource(named: "tabla.wav")

        #expect(url.baseURL == nil)
        #expect(url == URL(fileURLWithPath: url.path))
    }

    @Test("resource(named:) returns URL under resourcesDirectory")
    func resourceNamedPath() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)
        let url = br.resource(named: "test.wav")
        #expect(url.path.hasPrefix(br.resourcesDirectory.path))
        #expect(url.lastPathComponent == "test.wav")
    }

    @Test("resource(named:) preserves file name with spaces")
    func resourceNamedWithSpaces() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)
        let url = br.resource(named: "no metadata.mp3")
        #expect(url.lastPathComponent == "no metadata.mp3")
    }

    @Test("resource(named:) preserves file extension")
    func resourceNamedExtension() {
        let br = BundleResources(bundleURL: Bundle.module.bundleURL)
        let url = br.resource(named: "example.flac")
        #expect(url.pathExtension == "flac")
    }

    @Test("two instances with same bundleURL produce same resource URLs")
    func consistentResourceURLs() {
        let url = Bundle.module.bundleURL
        let a = BundleResources(bundleURL: url)
        let b = BundleResources(bundleURL: url)
        #expect(a.resource(named: "foo.wav") == b.resource(named: "foo.wav"))
    }

    @Test("different bundleURLs produce different resource URLs")
    func differentBundleURLs() {
        let a = BundleResources(bundleURL: URL(fileURLWithPath: "/tmp/bundleA.bundle"))
        let b = BundleResources(bundleURL: URL(fileURLWithPath: "/tmp/bundleB.bundle"))
        #expect(a.resource(named: "test.wav") != b.resource(named: "test.wav"))
    }
}
