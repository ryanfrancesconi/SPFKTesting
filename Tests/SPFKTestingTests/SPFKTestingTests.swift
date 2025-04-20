import Foundation
@testable import SPFKTesting
import Testing

@Suite(.serialized)
class ResourcesTests: TestCaseModel {
    lazy var bin: URL = createBin(suite: "ResourcesTests")
    deinit {
        removeBin()
    }

    @Test func testResources() async throws {
        let tmpfile = try copy(to: bin, url: wav_bext_v2)

        #expect(FileManager.default.fileExists(atPath: tmpfile.path))
    }
}
