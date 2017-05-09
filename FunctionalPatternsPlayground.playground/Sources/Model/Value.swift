import Foundation

public struct Info<Value> {
    
    // MARK: Properties
    public let value: Value
    
    public init(value: Value) {
        self.value = value
    }
}
