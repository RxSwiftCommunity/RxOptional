import Foundation
import RxCocoa

public extension Driver where Element: Occupiable {
    /**
     Filter out empty occupibales.

     - returns: Driver of only non-empty occupiables.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func filterEmpty() -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            guard element.isNotEmpty else {
                return Driver<Element>.empty()
            }
            return Driver<Element>.just(element)
        }
    }

    /**
     When empty uses handler to call another Driver otherwise passes elemets.

     - parameter handler: Empty handler function, producing another Driver.
     Guarantees non-empty by fatalErroring when handler returns an Driver
     with empty elements.

     - returns: Driver containing the source sequence's elements,
     followed by the elements produced by the handler's resulting observable
     sequence when element was empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnEmpty(handler: () -> Driver<Element>) -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            guard element.isNotEmpty else {
                return handler()
                    .fatalErrorOnEmpty()
            }
            return Driver<Element>.just(element)
        }
    }

    /**
     Unwraps optional values and if finds nil fatalErrors.

     During release builds fatalErrors are logged. Durring Debug builds
     continutes after logging fatalError.

     - returns: Driver of unwrapped elements.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnEmpty() -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            guard element.isNotEmpty else {
                RxOptionalFatalError(RxOptionalError.EmptyOccupiable(Element.self))
                return Driver.empty()
            }
            return Driver<Element>.just(element)
        }
    }
}
