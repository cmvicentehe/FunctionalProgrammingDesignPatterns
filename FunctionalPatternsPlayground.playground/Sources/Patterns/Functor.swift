import Foundation

public class Functor<Entry, Result> {
     //MARK: - Attributes
    public let value: Entry
    
    public init(value: Entry) {
        self.value = value
    }
    
    public func map(function: ((Entry) -> Result)) -> Result {
        return function(self.value)
    }
}
