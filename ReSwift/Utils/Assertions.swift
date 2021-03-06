//
//  Assertions
//  Copyright © 2015 mohamede1945. All rights reserved.
//  https://github.com/mohamede1945/AssertionsTestingExample
//

import Foundation

/// drop-in fatalError replacement for testing

/**
 Swift.fatalError wrapper for catching in tests

 - parameter message: Message to be wrapped
 - parameter file:    Calling file
 - parameter line:    Calling line
 */
#if swift(>=3)
@noreturn internal func raiseFatalError(_ message: @autoclosure () -> String = "",
                                 file: StaticString = #file, line: UInt = #line) {
    Assertions.fatalErrorClosure(message(), file, line)
    repeat {
        RunLoop.current.run()
    } while (true)
}
#else
@noreturn internal func raiseFatalError(@autoclosure message: () -> String = "",
                                              file: StaticString = #file, line: UInt = #line) {
    Assertions.fatalErrorClosure(message(), file, line)
    repeat {
        NSRunLoop.currentRunLoop().run()
    } while (true)
}
#endif

/// Stores custom assertions closures, by default it points to Swift functions. But test target can
/// override them.
internal class Assertions {
    internal static var fatalErrorClosure = swiftFatalErrorClosure
    internal static let swiftFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
}
