# SPFKTesting

[![Version](https://img.shields.io/github/v/tag/ryanfrancesconi/spfk-testing)](https://github.com/ryanfrancesconi/spfk-testing/tags)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-testing%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ryanfrancesconi/spfk-testing)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-testing%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ryanfrancesconi/spfk-testing)

A Swift package providing shared test resources and utilities for all SPFK test targets. Bundles a catalog of audio, video and image files used across the SPFK ecosystem, resolved against either bundle layout SwiftPM produces.

## Overview

SPFKTesting provides two main components:

- **`TestBundleResources`** — A `Sendable` singleton exposing 60+ named audio, video and image test files organized into collections by purpose (format coverage, metadata markers, edge cases).
- **`Tag` extensions** — Custom Swift Testing tags (`development`, `file`, `automation`, `realtime`, `engine`) for categorizing tests across SPFK modules.

## Key Types

### TestBundleResources

Singleton providing typed access to bundled test resources. Used by downstream packages for audio format testing, metadata parsing, and file I/O validation.

```swift
let resources = TestBundleResources.shared

// Access individual files
let wav = resources.tabla_wav
let mp3 = resources.mp3_id3

// Iterate format collections
for url in resources.formats {
    // tabla.aac, tabla.aif, tabla.caf, tabla.flac,
    // tabla.m4a, tabla.mp3, tabla.mp4, tabla.wav (+ tabla.ogg on macOS)
}

for url in resources.markerFormats {
    // Formats supporting RIFF/Chapter markers and metadata
}

for url in resources.audioCases {
    // Diverse set for broad audio testing
}
```

`formats` and `markerFormats` are the AVFoundation-openable series. The Matroska members of the tabla series are deliberately outside both, since nothing in AVFoundation can open them — reach them by name (`tabla_mka`, `tabla_flac_mka`, `tabla_pcm_mka`).

### BundleResources

Generic resource resolver that maps file names to URLs within a bundle.

**The two bundle layouts are a build-system difference, not a platform one.** Xcode writes `Contents/Resources`; SwiftPM's CLI build writes the resources flat at the bundle root. Both occur on macOS, so `resourcesDirectory` asks `Bundle` for its own `resourceURL` rather than appending a path, and a fixture resolves under `xcodebuild` and `swift test` alike.

```swift
let br = BundleResources(bundleURL: Bundle.module.bundleURL)
let url = br.resource(named: "tabla.wav")
```

### Test Tags

Custom tags for filtering test execution in Swift Testing test plans:

```swift
@Test(.tags(.file))
func readWavMetadata() { ... }

@Test(.tags(.realtime))
func displayLinkTiming() { ... }
```

## Bundled Resources

### Audio (30 files, plus `keys/` and `rated/`)

**The tabla series is same-audio-different-format** — every member is the same performance, so a test can assert one against another. Two caveats live in the series itself: `tabla.aac` and `tabla.m4a` carry encoder priming the container does not declare, so they are offset from the rest, while `tabla_flac.mka` and `tabla_pcm.mka` are sample-exact against `tabla.wav`.

| Resource | Purpose |
|----------|---------|
| `tabla.*` (10 formats) | Format coverage: AAC, AIF, CAF, FLAC, M4A, MKA, MP3, MP4, OGG, WAV |
| `tabla_flac.mka` | FLAC in Matroska — lossless, sample-exact against `tabla.wav` |
| `tabla_pcm.mka` | 24-bit PCM in Matroska — no converter in the decode path |
| `tabla_6_channel.wav` | Multi-channel audio |
| `tabla_legacy_picture.flac` | Legacy XiphComment `METADATA_BLOCK_PICTURE` artwork |
| `and-oh-how-they-danced.mp3` | ID3 metadata |
| `and-oh-how-they-danced.wav` | BEXT v2 metadata |
| `and-oh-how-they-danced_2.wav` | BEXT v2 variant |
| `123456789_60BPM_48k.wav` | BEXT v1, tempo reference |
| `ITUNSMPB.m4a` | iTunes gapless priming atom |
| `cowbell.wav` | General audio |
| `cowbell_bext.wav` | BEXT metadata |
| `pink_noise.wav` | Signal processing reference |
| `no metadata.mp3` | No metadata edge case |
| `xmp.mp3` | XMP metadata |
| `toc_many_children.mp3` | Complex TOC structure |
| `no_data_chunk.wav` | Missing data chunk edge case |
| `ixml.wav` | Full iXML specification |
| `bext_ixml_external.flac` | BEXT and iXML in FLAC APPLICATION blocks |
| `boom.addAudio` | Custom extension (M4A internally) |
| `keys/` (12 files) | Musical key detection reference, one per chromatic root |
| `rated/` (6 files) | 80/100 star rating across WAV, MP3, FLAC, M4A, OGG, AIF |

### Video (6 files)

Matroska is absent from `AVURLAsset.audiovisualTypes()`, so these exist to exercise the demuxer in `spfk-matroska` — which is also why an audio-only `.mov` is not a substitute for `sample.mov`.

| Resource | Purpose |
|----------|---------|
| `sample.mov` | A complete 6 KB QuickTime movie — a real container with a video track |
| `sample.mkv` | H.264 + AAC in Matroska |
| `sample.webm` | VP9 + Opus — no `avcC`, so it catches code assuming every track has codec private data |
| `sample.mka` | Matroska audio with no video track |
| `sample-nested-seekhead.mkv` | SeekHead pointing at a second SeekHead |
| `sample-interleaved-cues.mkv` | Cues indexing only the video track, as most muxers write them |

### Images (4 files)

| Resource | Purpose |
|----------|---------|
| `sharksandwich.jpg` | Image metadata testing |
| `sharksandwich.heic` | HEIC read path |
| `sharksandwich.webp` | WebP — readable but not writable, so artwork transcodes to JPEG |
| `songbird.jpg` | Second image, for collection and comparison tests |

## Usage

Add SPFKTesting as a dependency in your test target only:

```swift
.testTarget(
    name: "MyPackageTests",
    dependencies: ["SPFKTesting"]
)
```

## Requirements

- **Platforms:** macOS 13+
- **Swift:** 6.2+

## About

Spongefork is the personal software projects of musician and developer [Ryan Francesconi](https://spongefork.com). Dedicated to creative sound manipulation, his first application, Spongefork, was released in 1999 for macOS 8. From 2026, Spongefork returns as his software container for more musical experimentation. In addition to [software releases](https://spongefork.com/shadowtag/), open source components can be found on his [GitHub page](https://github.com/ryanfrancesconi).
