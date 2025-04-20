// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi/SPFKUtils

import Foundation

@available(macOS 13, *)
public protocol TestCaseModel: AnyObject {}

@available(macOS 13, *)
extension TestCaseModel {
    var testBundle: URL {
        let bundleURL = Bundle(for: Self.self).bundleURL

        return bundleURL
            .appending(component: "Contents")
            .appending(component: "Resources")
            .appending(component: "SPFKTesting_SPFKTesting.bundle")
    }

    func getResource(named name: String) -> URL {
        testBundle
            .appending(component: "Contents")
            .appending(component: "Resources")
            .appending(component: name)
    }
}

@available(macOS 13, *)
extension TestCaseModel {
    var defaultURL: URL {
        FileManager.default.temporaryDirectory.appendingPathComponent("SPFKTesting")
    }

    public func createBin(suite: String, in baseURL: URL? = nil) -> URL {
        var url = baseURL ?? defaultURL

        url = url.appendingPathComponent(suite)

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                Swift.print(error)

                if url != FileManager.default.temporaryDirectory {
                    return createBin(suite: suite, in: FileManager.default.temporaryDirectory)
                }
            }
        }

        return url
    }

    func removeBin() {
        try? FileManager.default.removeItem(at: defaultURL)
    }

    public func copy(to bin: URL, url input: URL) throws -> URL {
        let tmp = bin.appendingPathComponent(input.lastPathComponent)
        try? FileManager.default.removeItem(at: tmp)
        try FileManager.default.copyItem(at: input, to: tmp)
        return tmp
    }

    public func createTempFile(for suite: String, source: URL) throws -> URL? {
        let bin = createBin(suite: suite)
        let tmpfile = try copy(to: bin, url: source)

        guard FileManager.default.fileExists(atPath: tmpfile.path) else { return nil }

        return tmpfile
    }
}

@available(macOS 13, *)
extension TestCaseModel {
    public func wait(sec timeout: TimeInterval) async {
        try? await Task.sleep(seconds: timeout)
    }

    public func wait(
        for condition: @escaping @autoclosure () -> Bool,
        timeout: TimeInterval,
        polling: TimeInterval = 0.1
    ) async throws {
        let inTime = Date()
        let timeoutTime = inTime + timeout

        var timedOut = false

        while true {
            if Date() >= timeoutTime {
                timedOut = true
                break
            }

            await wait(sec: polling)

            let result = condition()

            if result {
                break
            }
        }

        if timedOut {
            throw NSError(description: "Timeout failed to meet condition")
        }
    }
}

// Test files
@available(macOS 13, *)
extension TestCaseModel {
    var mp3_id3: URL { getResource(named: "and-oh-how-they-danced.mp3") }
    var wav_bext_v2: URL { getResource(named: "and-oh-how-they-danced.wav") }
    var tabla_mp4: URL { getResource(named: "tabla.mp4") }
    var toc_many_children: URL { getResource(named: "toc_many_children.mp3") }
    var sharksandwich: URL { getResource(named: "sharksandwich.jpg") }
}

// MARK: -

extension Task where Success == Never, Failure == Never {
    internal static func sleep(seconds: TimeInterval) async throws {
        let duration = UInt64(seconds * 1000000000)
        try await Task.sleep(nanoseconds: duration)
    }
}

extension NSError {
    internal convenience init(
        description: String,
        code: Int = 1,
        domain: String = Bundle.main.bundleIdentifier ?? "SPFKUtils"
    ) {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: description]

        self.init(
            domain: domain,
            code: code,
            userInfo: userInfo
        )
    }
}
