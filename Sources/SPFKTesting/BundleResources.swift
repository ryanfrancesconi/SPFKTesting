import Foundation

public class BundleResources: AnyObject {
    public static let shared = BundleResources()

    public var bundleURL: URL {
        Bundle.module.bundleURL
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

// MARK: - Test files

extension BundleResources {
    public var mp3_id3: URL {
        resource(named: "and-oh-how-they-danced.mp3")
    }

    public var wav_bext_v2: URL {
        resource(named: "and-oh-how-they-danced.wav")
    }

    public var tabla_mp4: URL {
        resource(named: "tabla.mp4")
    }

    public var tabla_wav: URL {
        resource(named: "tabla.wav")
    }

    public var toc_many_children: URL {
        resource(named: "toc_many_children.mp3")
    }

    public var cowbell_wav: URL {
        resource(named: "cowbell.wav")
    }

    public var sharksandwich: URL {
        resource(named: "sharksandwich.jpg")
    }
}
