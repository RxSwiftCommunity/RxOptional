import Foundation
import RxSwift

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType: Occupiable {
    /**
     Replaces empty occupiable elements with result returned by `handler`.
     
     - parameter handler: empty handler throwing function that returns `Single` of non-empty occupiable elements.
     
     - returns: `Single` of the source `Single`'s occupiable elements, with empty occupiable elements replaced by the handler's returned non-empty occupiable elements.
     */
    
    public func catchOnEmpty(_ handler: @escaping () throws -> PrimitiveSequence<SingleTrait, ElementType>) -> PrimitiveSequence<SingleTrait, ElementType> {
        return self.flatMap { element -> PrimitiveSequence<SingleTrait, ElementType> in
            guard element.isNotEmpty else {
                return try handler()
            }
            return PrimitiveSequence<SingleTrait, ElementType>.just(element)
        }
    }
    
    /**
     Throws an error if the source `Single` contains an empty occupiable element; otherwise returns original source `Single` of non-empty occupiable elements.
     
     - parameter error: error to throw when an empty occupiable element is encountered. Defaults to `RxOptionalError.EmptyOccupiable`.
     
     - throws: `error` if an empty occupiable element is encountered.
     
     - returns: original source `Single` of non-empty occupiable elements if it contains no empty occupiable elements.
     */
    
    public func errorOnEmpty(_ error: Error = RxOptionalError.emptyOccupiable(ElementType.self)) -> PrimitiveSequence<SingleTrait, ElementType> {
        return self.map { element in
            guard element.isNotEmpty else {
                throw error
            }
            return element
        }
    }
}
