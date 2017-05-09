import Foundation

public enum Maybe<Value> {
    case just(Value)
    case nothing
}
