
import Foundation
import Testing

@available(macOS 13, *)
class BinTestCase: NSObject, TestCaseModel {
    lazy var bin: URL = createBin(suite: className)

    var resources = TestBundle()

    /// in cases where you want to check the actual files after the test completes
    /// can set this to false to leave in temp
    var deleteBinOnExit = true

    deinit {
        guard deleteBinOnExit else { return }

        removeBin()
    }

    func removeBin() {
        do {
            Swift.print("Removing \(bin.path)")

            try FileManager.default.removeItem(at: bin)

            if FileManager.default.fileExists(atPath: defaultURL.path) {
                try FileManager.default.removeItem(at: defaultURL)
            }

        } catch {
            Swift.print(error)
        }
    }

    func copyToBin(url: URL) throws -> URL {
        try copy(to: bin, url: url)
    }
}
