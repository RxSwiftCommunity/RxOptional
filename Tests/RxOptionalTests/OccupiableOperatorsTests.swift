import Quick
import Nimble
import RxSwift
import RxCocoa
import RxOptional

class OccupiableOperatorsSpec: QuickSpec {
    override func spec() {
        describe("filterEmpty") {
            context("Observable") {
                it("filters out empty arrays") {
                    Observable<[Int]>
                        .of([1], [], [3, 4], [5])
                        .filterEmpty()
                        .toArray()
                        .subscribe(onSuccess: {
                            expect($0[0]).to(equal([1]))
                            expect($0[1]).to(equal([3, 4]))
                            expect($0[2]).to(equal([5]))
                        })
                        .dispose()

                }

                it("filters out empty strings") {
                    Observable<String>
                        .of("one", "", "three", "four")
                        .filterEmpty()
                        .toArray()
                        .subscribe(onSuccess: {
                            expect($0).to(equal(["one", "three", "four"]))
                        })
                        .dispose()

                }
            }

            context("Driver") {
                it("filters out empty arrays") {
                    Driver<[Int]>
                        .of([1], [], [3, 4], [5])
                        .filterEmpty()
                        .asObservable()
                        .toArray()
                        .subscribe(onSuccess: {
                            expect($0[0]).to(equal([1]))
                            expect($0[1]).to(equal([3, 4]))
                            expect($0[2]).to(equal([5]))
                        })
                        .dispose()

                }

                it("filters out empty strings") {
                    Driver<String>
                        .of("one", "", "three", "four")
                        .filterEmpty()
                        .asObservable()
                        .toArray()
                        .subscribe(onSuccess: {
                            expect($0).to(equal(["one", "three", "four"]))
                        })
                        .dispose()
                    
                }
            }
        }

        describe("catchOnEmpty") {
            context("Observable") {
                it("emits default error") {
                    Observable<[Int]>
                        .of([1], [], [3, 4], [5])
                        .catchOnEmpty {
                            return Observable<[Int]>.just([2])
                        }
                        .toArray()
                        .subscribe(onSuccess: {
                            expect($0[0]).to(equal([1]))
                            expect($0[1]).to(equal([2]))
                            expect($0[2]).to(equal([3, 4]))
                            expect($0[3]).to(equal([5]))
                        })
                        .dispose()
                }
            }

            context("Driver") {
                Driver<[Int]>
                    .of([1], [], [3, 4], [5])
                    .catchOnEmpty {
                        return Driver<[Int]>.just([2])
                    }
                    .asObservable()
                    .toArray()
                    .subscribe(onSuccess: {
                        expect($0[0]).to(equal([1]))
                        expect($0[1]).to(equal([2]))
                        expect($0[2]).to(equal([3, 4]))
                        expect($0[3]).to(equal([5]))
                    })
                    .dispose()
            }
        }

        describe("errorOnEmpty") {
            context("Observable") {
                Observable<[Int]>
                    .of([1], [], [3, 4], [5])
                    .errorOnEmpty()
                    .toArray()
                        .subscribe { event in
                            switch event {
                            case .success(let element):
                                expect(element[0]).to(equal([1]))
                                expect(element[1]).to(equal([3, 4]))
                                expect(element[2]).to(equal([5]))
                            case .error(let error):
                                // FIXME: There should be a better way to do this and to check a more specific error.
                                expect { throw error }
                                    .to(throwError(errorType: RxOptionalError.self))
                            }
                        }
                        .dispose()
            }
        }
    }
}
