import Foundation
import RxSwift

public extension ObservableType where E: Occupiable {
    /**
     Passes value if not empty. When empty uses handler to call another Observable

     - parameter handler: Empty handler function, producing another observable sequence

     - returns: An observable sequence containing the source sequence's elements,
     followed by the elements produced by the handler's resulting observable
     sequence when element was empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnEmpty(handler: () throws -> Observable<E>) -> Observable<E> {
        return self.flatMap { element -> Observable<E> in
            if element.isEmpty {
                return try handler()
            } else {
                return Observable<E>.just(element)
            }
        }
    }

    /**
     Passes value if not empty. When empty throws error.

     - parameter error: Error to throw when empty

     - returns: Observable containing the source sequence's elements,
     or error if empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func errorOnEmpty(error: ErrorType) -> Observable<E> {
        return self.flatMap { element -> Observable<E> in
            if element.isEmpty {
                throw error
            } else {
                return Observable<E>.just(element)
            }
        }
    }

    /**
     Unwraps optional values and if finds nil fatalErrors

     - returns: Observbale of unwrapped value
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnEmpty() -> Observable<E> {
        return self.flatMap { element -> Observable<E> in
            if element.isEmpty {
                fatalError("Empty object of type \(String(E.self))")
            } else {
                return Observable<E>.just(element)
            }
        }
    }
}