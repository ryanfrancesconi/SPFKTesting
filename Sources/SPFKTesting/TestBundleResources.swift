import Foundation

public final class TestBundleResources: BundleResources, @unchecked Sendable {
    public static let shared = TestBundleResources(bundleURL: Bundle.module.bundleURL)

    public var audioCases: [URL] { [
        mp3_id3, wav_bext_v2, tabla_mp4, tabla_wav, tabla_6_channel, cowbell_wav, pink_noise,
    ] }

    public var formats: [URL] { [
        tabla_aac,
        tabla_aif,
        tabla_flac,
        tabla_m4a,
        tabla_mp3,
        tabla_mp4,
        tabla_ogg,
        tabla_wav,
    ] }
}

// MARK: - Audio

extension TestBundleResources {
    public var mp3_no_metadata: URL {
        resource(named: "no metadata.mp3")
    }

    public var mp3_xmp: URL {
        resource(named: "xmp.mp3")
    }

    public var mp3_id3: URL {
        resource(named: "and-oh-how-they-danced.mp3")
    }

    public var wav_bext_v1: URL {
        resource(named: "123456789_60BPM_48k.wav")
    }

    public var counting_123456789_60BPM_48k: URL {
        wav_bext_v1
    }

    public var wav_bext_v2: URL {
        resource(named: "and-oh-how-they-danced.wav")
    }

    public var wav_bext_v2b: URL {
        resource(named: "and-oh-how-they-danced_2.wav")
    }

    public var tabla_aac: URL {
        resource(named: "tabla.aac")
    }

    public var tabla_mp4: URL {
        resource(named: "tabla.mp4")
    }

    public var tabla_wav: URL {
        resource(named: "tabla.wav")
    }

    public var tabla_flac: URL {
        resource(named: "tabla.flac")
    }

    public var tabla_ogg: URL {
        resource(named: "tabla.ogg")
    }

    public var tabla_aif: URL {
        resource(named: "tabla.aif")
    }

    public var tabla_caf: URL {
        resource(named: "tabla.caf")
    }

    public var tabla_mp3: URL {
        resource(named: "tabla.mp3")
    }

    public var tabla_m4a: URL {
        resource(named: "tabla.m4a")
    }

    public var tabla_6_channel: URL {
        resource(named: "tabla_6_channel.wav")
    }

    public var toc_many_children: URL {
        resource(named: "toc_many_children.mp3")
    }

    public var cowbell_wav: URL {
        resource(named: "cowbell.wav")
    }

    public var pink_noise: URL {
        resource(named: "pink_noise.wav")
    }

    public var no_data_chunk: URL {
        resource(named: "no_data_chunk.wav")
    }
}

// MARK: - Images

extension TestBundleResources {
    public var sharksandwich: URL {
        resource(named: "sharksandwich.jpg")
    }
}
