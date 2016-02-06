import RxCocoa

public extension Driver where Element: OptionalType {
    /**
     Unwrap and filter out nil values.

     - returns: Driver with only succefully unwrapped values.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterNil() -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            if let value = element.value {
                return Driver<Element.Wrapped>.just(value)
            } else {
                return Driver<Element.Wrapped>.empty()
            }
        }
    }

    /**
     Unwraps optional values and if finds nil fatalErrors.

     - returns: Driver with unwrapped value.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnNil() -> Driver<Element.Wrapped> {
        return self.flatMap { element -> Driver<Element.Wrapped> in
            if let value = element.value {
                return Driver<Element.Wrapped>.just(value)
            } else {
                RxOptionalFatalError(RxOptionalError.FoundNilWhileUnwrappingOptional(Element.self))
                return Driver<Element.Wrapped>.empty()
            }
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
            if let value = element.value {
                return value
            } else {
                return valueOnNil
            }
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
            if let value = element.value {
                return Driver<Element.Wrapped>.just(value)
            } else {
                return handler()
            }
        }
    }
}