import Foundation
@testable import SPFKTesting
import Testing

@Suite(.serialized)
class ResourcesTests: BinTestCase {
    @Test func testResources() async throws {
        let tmpfile = try copyToBin(url: resources.wav_bext_v2)

        #expect(FileManager.default.fileExists(atPath: tmpfile.path))
    }
    
    @Test func testBundle() async throws {
        let bundle = TestBundle()
        
        Swift.print(bundle.bundleURL)
    }
}
