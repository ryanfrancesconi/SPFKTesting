// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi/spfk-testing

import Testing

extension Tag {
    /// A tag to indicate this is a development test rather than functionality that should be unit tested
    @Tag public static var development: Self
    @Tag public static var file: Self
    @Tag public static var automation: Self
    @Tag public static var realtime: Self
    @Tag public static var engine: Self
    @Tag public static var audioUnit: Self
    @Tag public static var hardware: Self

    /// Undo behavior in either product: the action enum, the handlers, and the harness that reaches
    /// them. Unlike the tags above — which say what a test *needs* — this says what it is *about*,
    /// so a cross-package run can be assembled without naming each suite.
    @Tag public static var undo: Self
}
