import Foundation
import RxCocoa

public extension Driver where Element: Occupiable {
    /**
     Passes value if not empty. When empty uses handler to call another Driver

     - parameter handler: Empty handler function, producing another Driver

     - returns: Driver containing the source sequence's elements,
     followed by the elements produced by the handler's resulting observable
     sequence when element was empty.
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func catchOnEmpty(handler: () -> Driver<Element>) -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            if element.isEmpty {
                return handler()
            } else {
                return Driver<Element>.just(element)
            }
        }
    }

    /**
     Unwraps optional values and if finds nil fatalErrors

     - returns: Driver of nwrapped value
     */
    @warn_unused_result(message="http://git.io/rxs.uo")
    public func fatalErrorOnEmpty() -> Driver<Element> {
        return self.flatMap { element -> Driver<Element> in
            if element.isEmpty {
                return Driver<Element>.just(element)
            } else {
                RxFatalError("Empty object of type \(String(Element.self))")
                return Driver.empty()
            }
        }
    }
}
