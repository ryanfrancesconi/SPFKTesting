// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi/spfk-testing

import Foundation

public final class TestBundleResources: Sendable {
    let internalResources: BundleResources

    public var bundleURL: URL { internalResources.bundleURL }
    public var resourcesDirectory: URL { internalResources.resourcesDirectory }

    public static let shared = TestBundleResources(bundleURL: Bundle.module.bundleURL)

    public init(bundleURL: URL) {
        internalResources = BundleResources(bundleURL: bundleURL)
    }
}

// MARK: - Audio

extension TestBundleResources {
    public var audioCases: [URL] { [
        mp3_id3, wav_bext_v1, wav_bext_v2, tabla_mp4, tabla_wav, tabla_6_channel, cowbell_wav, pink_noise,
    ] }

    public var formats: [URL] {
        var result = [tabla_aac, tabla_aif, tabla_caf, tabla_flac, tabla_m4a, tabla_mp3, tabla_mp4, tabla_wav]
        #if os(macOS)
            result.append(tabla_ogg)
        #endif
        return result
    }

    /// format files which support either RIFF or Chapter markers and other metadata
    public var markerFormats: [URL] {
        var result = [tabla_aif,
                      tabla_flac,
                      tabla_m4a,
                      tabla_mp3,
                      tabla_mp4,
                      tabla_wav]
        #if os(macOS)
            result.append(tabla_ogg)
        #endif
        return result
    }

    public var ituns_mpb_m4a: URL {
        internalResources.resource(named: "ITUNSMPB.m4a")
    }

    public var mp3_no_metadata: URL {
        internalResources.resource(named: "no metadata.mp3")
    }

    public var mp3_xmp: URL {
        internalResources.resource(named: "xmp.mp3")
    }

    public var mp3_id3: URL {
        internalResources.resource(named: "and-oh-how-they-danced.mp3")
    }

    public var wav_bext_v1: URL {
        internalResources.resource(named: "123456789_60BPM_48k.wav")
    }

    public var counting_123456789bpm60_48k: URL {
        wav_bext_v1
    }

    public var wav_bext_v2: URL {
        internalResources.resource(named: "and-oh-how-they-danced.wav")
    }

    public var wav_bext_v2b: URL {
        internalResources.resource(named: "and-oh-how-they-danced_2.wav")
    }

    public var tabla_aac: URL {
        internalResources.resource(named: "tabla.aac")
    }

    public var tabla_mp4: URL {
        internalResources.resource(named: "tabla.mp4")
    }

    public var tabla_wav: URL {
        internalResources.resource(named: "tabla.wav")
    }

    public var tabla_flac: URL {
        internalResources.resource(named: "tabla.flac")
    }

    /// FLAC with BEXT and iXML APPLICATION blocks authored by metaflac (not our bridge).
    /// Used to verify that externally-produced APPLICATION blocks are read correctly.
    public var flac_bext_ixml_external: URL {
        internalResources.resource(named: "bext_ixml_external.flac")
    }

    public var tabla_ogg: URL {
        internalResources.resource(named: "tabla.ogg")
    }

    public var tabla_aif: URL {
        internalResources.resource(named: "tabla.aif")
    }

    public var tabla_caf: URL {
        internalResources.resource(named: "tabla.caf")
    }

    public var tabla_mp3: URL {
        internalResources.resource(named: "tabla.mp3")
    }

    public var tabla_m4a: URL {
        internalResources.resource(named: "tabla.m4a")
    }

    public var tabla_6_channel: URL {
        internalResources.resource(named: "tabla_6_channel.wav")
    }

    public var toc_many_children: URL {
        internalResources.resource(named: "toc_many_children.mp3")
    }

    public var cowbell_wav: URL {
        internalResources.resource(named: "cowbell.wav")
    }

    public var cowbell_bext_wav: URL {
        internalResources.resource(named: "cowbell_bext.wav")
    }

    public var pink_noise: URL {
        internalResources.resource(named: "pink_noise.wav")
    }

    public var no_data_chunk: URL {
        internalResources.resource(named: "no_data_chunk.wav")
    }

    public var ixml_chunk: URL {
        internalResources.resource(named: "ixml.wav")
    }

    public var addAudio: URL {
        // is m4a internally
        internalResources.resource(named: "boom.addAudio")
    }
}

extension TestBundleResources {
    // MARK: - Pre-rated fixtures (rating=80 embedded by external tooling)

    /// WAV with ID3v2 POPM frame (WMP email, byte=196 = 4 stars = normalized 80).
    public var rated_80_wav: URL {
        internalResources.resource(named: "rated_80.wav")
    }

    /// MP3 with ID3v2 POPM frame (WMP email, byte=196 = 4 stars = normalized 80).
    public var rated_80_mp3: URL {
        internalResources.resource(named: "rated_80.mp3")
    }

    /// FLAC with Xiph RATING=80 and FMPS_RATING=0.800.
    public var rated_80_flac: URL {
        internalResources.resource(named: "rated_80.flac")
    }

    /// M4A with freeform ----:com.apple.iTunes:RATING atom = "80".
    public var rated_80_m4a: URL {
        internalResources.resource(named: "rated_80.m4a")
    }

    /// OGG Vorbis with Xiph RATING=80 and FMPS_RATING=0.800.
    public var rated_80_ogg: URL {
        internalResources.resource(named: "rated_80.ogg")
    }

    /// AIFF with ID3v2 POPM frame (WMP email, byte=196 = 4 stars = normalized 80).
    public var rated_80_aif: URL {
        internalResources.resource(named: "rated_80.aif")
    }
}

// MARK: - Musical Key Audio

extension TestBundleResources {
    public var key_a_major: URL {
        internalResources.resource(named: "a_major.mp3")
    }

    public var key_asharp_major: URL {
        internalResources.resource(named: "asharp_major.mp3")
    }

    public var key_b_major: URL {
        internalResources.resource(named: "b_major.mp3")
    }

    public var key_c_major: URL {
        internalResources.resource(named: "c_major.mp3")
    }

    public var key_csharp_major: URL {
        internalResources.resource(named: "csharp_major.mp3")
    }

    public var key_d_major: URL {
        internalResources.resource(named: "d_major.mp3")
    }

    public var key_dsharp_major: URL {
        internalResources.resource(named: "dsharp_major.mp3")
    }

    public var key_e_major: URL {
        internalResources.resource(named: "e_major.mp3")
    }

    public var key_f_major: URL {
        internalResources.resource(named: "f_major.mp3")
    }

    public var key_fsharp_major: URL {
        internalResources.resource(named: "fsharp_major.mp3")
    }

    public var key_g_major: URL {
        internalResources.resource(named: "g_major.mp3")
    }

    public var key_gsharp_major: URL {
        internalResources.resource(named: "gsharp_major.mp3")
    }

    /// All 12 major key audio files for testing musical key detection.
    public var majorKeyAudioFiles: [(note: String, url: URL)] {
        [
            ("C", key_c_major),
            ("C#", key_csharp_major),
            ("D", key_d_major),
            ("D#", key_dsharp_major),
            ("E", key_e_major),
            ("F", key_f_major),
            ("F#", key_fsharp_major),
            ("G", key_g_major),
            ("G#", key_gsharp_major),
            ("A", key_a_major),
            ("A#", key_asharp_major),
            ("B", key_b_major),
        ]
    }

    /// FLAC with artwork stored in a METADATA_BLOCK_PICTURE Vorbis comment entry
    /// and no native FLAC PICTURE block. Used to test XiphComment read fallback
    /// and migration to native PICTURE blocks.
    public var tabla_legacy_picture_flac: URL {
        internalResources.resource(named: "tabla_legacy_picture.flac")
    }
}

// MARK: - Video

extension TestBundleResources {
    /// A tiny but complete QuickTime movie, generated by `scripts/make-video-fixture.swift`.
    ///
    /// Built to serve every kind of video test from one 6 KB file, because the alternatives each
    /// fall short: an audio-only MP4 does not exercise the same format handlers as a `.mov`, and a
    /// single-frame movie has no duration to seek within.
    ///
    /// - 2 seconds, 160x120 (non-square, so aspect-ratio bugs surface), H.264 at 30fps
    /// - a keyframe every 15 frames, so a trim can land mid-GOP
    /// - visibly distinct frames, so a thumbnail-at-timestamp test can assert *which* frame it got
    /// - an AAC audio track, so track counts and audio-through-trim are testable
    /// - QuickTime user data: make, model, software, creation date, and an ISO 6709 location
    ///   (`+45.5152-122.6784+015.000/`, Portland) -- exactly what `QuickTimeUserData` reads
    public var sample_mov: URL {
        internalResources.resource(named: "sample.mov")
    }

    /// The same content as ``sample_mov``, remuxed into a Matroska container:
    ///
    ///     ffmpeg -i sample.mov -c copy \
    ///       -metadata title="SPFK Sample Matroska" -metadata artist="Spongefork" sample.mkv
    ///
    /// `-c copy` rather than a re-encode, so the streams are bit-identical to the `.mov` and any
    /// difference a test observes is the *container*, which is the only thing Matroska changes.
    /// Carries `title` and `artist` so a read can be asserted without writing first.
    ///
    /// **AVFoundation cannot open this file** — Matroska is absent from
    /// `AVURLAsset.audiovisualTypes()`. That is the point of the fixture: it exercises the
    /// TagLib-backed metadata path for a container the AV stack refuses, so anything reaching for
    /// `AVAsset` fails loudly here instead of silently working via a format that happens to be
    /// supported.
    public var sample_mkv: URL {
        internalResources.resource(named: "sample.mkv")
    }

    /// The same content as ``sample_mov`` re-encoded into WebM:
    ///
    ///     ffmpeg -i sample.mov -c:v libvpx-vp9 -crf 40 -b:v 0 -g 15 -c:a libopus -b:a 24k \
    ///       -metadata title="SPFK Sample WebM" -metadata artist="Spongefork" sample.webm
    ///
    /// A re-encode rather than the `-c copy` used for ``sample_mkv``, because WebM admits neither
    /// H.264 nor AAC — so this is VP9 video and Opus audio (resampled to Opus's native 48 kHz),
    /// still 160x120 and 2 seconds with a keyframe every 15 frames.
    ///
    /// Exists to prove the claim that one Matroska parser covers both containers: WebM is a
    /// Matroska profile, and the only thing that should differ is the EBML `DocType`. It is also
    /// the fixture that covers an **absent `CodecPrivate`** — VP9 needs no out-of-band setup data
    /// and carries none, where H.264 carries an `avcC`, so a code path that assumes every video
    /// track has one fails here and only here.
    public var sample_webm: URL {
        internalResources.resource(named: "sample.webm")
    }

    /// ``sample_mov``'s audio track alone, in a Matroska container:
    ///
    ///     ffmpeg -i sample.mov -vn -c:a copy \
    ///       -metadata title="SPFK Sample Matroska Audio" -metadata artist="Spongefork" sample.mka
    ///
    /// `-c copy`, so the AAC is bit-identical to the one in ``sample_mov`` and ``sample_mkv``.
    ///
    /// The audio-only case, which `.mka` is Matroska's own extension for. Worth having separately
    /// because a video-bearing file cannot exercise it: anything reaching for a video track finds
    /// one in ``sample_mkv`` and silently works, where here there is none to find.
    public var sample_mka: URL {
        internalResources.resource(named: "sample.mka")
    }
}

// MARK: - Images

extension TestBundleResources {
    public var sharksandwich: URL {
        internalResources.resource(named: "sharksandwich.jpg")
    }

    /// HEIC version of sharksandwich, for testing non-JPEG/PNG artwork decode.
    public var sharksandwich_heic: URL {
        internalResources.resource(named: "sharksandwich.heic")
    }

    /// WebP version of sharksandwich, for testing non-JPEG/PNG artwork decode.
    public var sharksandwich_webp: URL {
        internalResources.resource(named: "sharksandwich.webp")
    }

    /// A real photograph (yellow warbler on a branch) with an unambiguous subject,
    /// for testing ML image classification against genuine framework output.
    public var songbird: URL {
        internalResources.resource(named: "songbird.jpg")
    }
}
