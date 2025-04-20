import Foundation

// MARK: - Pulled from SPFKUtils - move to a SPFKBase to remove duplication

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
