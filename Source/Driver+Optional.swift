import RxCocoa

public extension Driver where Element: OptionalType {
    /**
     Unwraps and filters out `nil` elements.

     - returns: `Driver` of source `Driver`'s elements, with `nil` elements filtered out.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterNil() -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            guard let value = element.value else {
                return Driver<Element.Wrapped>.empty()
            }
            return Driver<Element.Wrapped>.just(value)
        }
    }

    /**
     Unwraps optional elements and replaces `nil` elements with `valueOnNil`.

     - parameter valueOnNil: value to use when `nil` is encountered.

     - returns: `Driver` of the source `Driver`'s unwrapped elements, with `nil` elements replaced by `valueOnNil`.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func replaceNilWith(valueOnNil: Element.Wrapped) -> Driver<Element.Wrapped> {
        return self.map { element -> E.Wrapped in
            guard let value = element.value else {
                return valueOnNil
            }
            return value
        }
    }

    /**
     Unwraps optional elements and replaces `nil` elements with result returned by `handler`.

     - parameter handler: `nil` handler function that returns `Driver` of non-`nil` elements.

     - returns: `Driver` of the source `Driver`'s unwrapped elements, with `nil` elements replaced by the handler's returned non-`nil` elements.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnNil(handler: () -> Driver<Element.Wrapped>) -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            guard let value = element.value else {
                return handler()
            }
            return Driver<Element.Wrapped>.just(value)
        }
    }
}