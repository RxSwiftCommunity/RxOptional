import RxCocoa

public extension Driver where Element: OptionalType {
    /**
     Unwrap and filter out nil values.

     - returns: Driver with only succefully unwrapped values.
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
     Unwraps optional values and if finds nil fatalErrors.

     During release builds fatalErrors are logged, behaves exactly like
     `.filterOnNil`. Durring Debug builds continutes after logging fatalError.

     - returns: Driver with unwrapped value.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnNil() -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            guard let value = element.value else {
                RxOptionalFatalError(RxOptionalError.FoundNilWhileUnwrappingOptional(Element.self))
                return Driver<Element.Wrapped>.empty()
            }
            return Driver<Element.Wrapped>.just(value)
        }
    }

    /**
     Unwraps optional and replace nil values with value.

     - parameter valueOnNil: Value to emit when nil is found.

     - returns: Driver with unwrapped value or nilValue.
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
     Unwraps element and passes value if not nil. When nil uses handler to call another Observable

     - parameter handler: Nil handler function, producing another observable sequence.

     - returns: Driver containing the source sequence's elements,
     followed by the elements produced by the handler's resulting observable
     sequence in case an nil was found while unwrapping.
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