import Foundation

// Originally from here: https://github.com/artsy/eidolon/blob/f95c0a5bf1e90358320529529d6bf431ada04c3f/Kiosk/App/SwiftExtensions.swift#L23-L40
// Credit to Artsy and @ashfurrow

// Anything that can hold a value (strings, arrays, etc.)
public protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

public extension Occupiable {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Collection: Occupiable { }
