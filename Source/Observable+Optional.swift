import Foundation
import RxSwift

// Some code originally from here: https://github.com/artsy/eidolon/blob/24e36a69bbafb4ef6dbe4d98b575ceb4e1d8345f/Kiosk/Observable%2BOperators.swift#L42-L62
// Credit to Artsy and @ashfurrow

public extension ObservableType where E: OptionalType {
    /**
     Unwraps and filters out `nil` elements.

     - returns: `Observable` of source `Observable`'s elements, with `nil` elements filtered out.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterNil() -> Observable<E.Wrapped> {
        return self.flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.value else {
                return Observable<E.Wrapped>.empty()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }

    /**
     Throws an error if the source `Observable` contains an empty element; otherwise returns original source `Observable` of non-empty elements.

     - parameter error: error to throw when an empty element is encountered. Defaults to `RxOptionalError.FoundNilWhileUnwrappingOptional`.

     - throws: `error` if an empty element is encountered.

     - returns: original source `Observable` of non-empty elements if it contains no empty elements.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func errorOnNil(error: ErrorType = RxOptionalError.FoundNilWhileUnwrappingOptional(E.self)) -> Observable<E.Wrapped> {
        return self.map { element -> E.Wrapped in
            guard let value = element.value else {
                throw error
            }
            return value
        }
    }

    /**
     Unwraps optional elements and replaces `nil` elements with `valueOnNil`.

     - parameter valueOnNil: value to use when `nil` is encountered.

     - returns: `Observable` of the source `Observable`'s unwrapped elements, with `nil` elements replaced by `valueOnNil`.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func replaceNilWith(valueOnNil: E.Wrapped) -> Observable<E.Wrapped> {
        return self.map { element -> E.Wrapped in
            guard let value = element.value else {
                return valueOnNil
            }
            return value
        }
    }

    /**
     Unwraps optional elements and replaces `nil` elements with result returned by `handler`.

     - parameter handler: `nil` handler throwing function that returns `Observable` of non-`nil` elements.

     - returns: `Observable` of the source `Observable`'s unwrapped elements, with `nil` elements replaced by the handler's returned non-`nil` elements.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnNil(handler: () throws -> Observable<E.Wrapped>) -> Observable<E.Wrapped> {
        return self.flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.value else {
                return try handler()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }
}
