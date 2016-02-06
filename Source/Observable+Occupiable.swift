import Foundation
import RxSwift

public extension ObservableType where E: Occupiable {
    /**
     Filter out empty occupibales.

     - returns: Observbale of only non-empty occupiables.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterEmpty() -> Observable<E> {
        return self.flatMap { element -> Observable<E> in
            if element.isNotEmpty {
                return Observable<E>.just(element)
            } else {
                return Observable<E>.empty()
            }
        }
    }

    /**
     When empty uses handler to call another Observbale otherwise passes elemets.

     - parameter handler: Empty handler function, producing another observable.
     Guarantees non-empty by throwing RxOptionalError.EmptyOccupiable is handler
     returns an Observable with empty elements.

     - returns: An observable sequence containing the source sequence's elements,
     followed by the elements produced by the handler's resulting observable
     sequence when element was empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnEmpty(handler: () throws -> Observable<E>) -> Observable<E> {
        return self.flatMap { element -> Observable<E> in
            if element.isEmpty {
                return try handler()
                    .errorOnEmpty()
            } else {
                return Observable<E>.just(element)
            }
        }
    }

    /**
     Passes value if not empty. When empty throws error.

     - parameter error: Error to throw when empty default to `RxError.NoElements`.

     - returns: Observable containing the source sequence's elements,
     or error if empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func errorOnEmpty(error: ErrorType = RxOptionalError.EmptyOccupiable(E.self)) -> Observable<E> {
        return self.map { element in
            if element.isEmpty {
                throw error
            } else {
                return element
            }
        }
    }

    /**
     Unwraps optional values and if finds nil fatalErrors

     - returns: Observbale of unwrapped value
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnEmpty() -> Observable<E> {
        return self.map { element in
            if element.isEmpty {
                RxOptionalFatalError(RxOptionalError.EmptyOccupiable(E.self))
                throw RxOptionalError.EmptyOccupiable(E.self)
            } else {
                return element
            }
        }
    }
}