import Foundation
import SPFKTesting
import Testing

final class TestBundleResourcesTests {
    
    @Test func bundle() async throws {
        print(TestBundleResources.shared.bundleURL)
    }

    @Test func resourcesDirectory() async throws {
        print(TestBundleResources.shared.resourcesDirectory)
    }
    
    @Test func exists() async throws {
        let url = TestBundleResources.shared.wav_bext_v2
        
        print(url.path)
        
        #expect(FileManager.default.fileExists(atPath: url.path))
    }
}
