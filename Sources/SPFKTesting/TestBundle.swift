import Foundation

@available(macOS 13, *)
class TestBundle: AnyObject {
    var bundleURL: URL {
        Bundle.module.bundleURL
    }

    var resourcesDirectory: URL {
        bundleURL
            .appending(component: "Contents")
            .appending(component: "Resources")
    }

    /// Look in the bundle for the file name requested
    func resource(named name: String) -> URL {
        resourcesDirectory.appending(component: name)
    }
}

// MARK: - Test files

@available(macOS 13, *)
extension TestBundle {
    var mp3_id3: URL {
        resource(named: "and-oh-how-they-danced.mp3")
    }

    var wav_bext_v2: URL {
        resource(named: "and-oh-how-they-danced.wav")
    }

    var tabla_mp4: URL {
        resource(named: "tabla.mp4")
    }

    var tabla_wav: URL {
        resource(named: "tabla.wav")
    }
    
    var toc_many_children: URL {
        resource(named: "toc_many_children.mp3")
    }

    var sharksandwich: URL {
        resource(named: "sharksandwich.jpg")
    }
}
