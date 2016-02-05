import Foundation

func RxFatalError(message: String) {
    #if DEBUG
        rxfatalError(message)
    #else
        print("fatalError: \(message)")
    #endif
}

@noreturn func rxFatalError(message: String) {
    fatalError(message)
}
