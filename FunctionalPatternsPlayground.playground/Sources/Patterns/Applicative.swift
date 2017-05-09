import Foundation

extension Optional {
    public func apply<ReturnType>(function: ((Wrapped) -> ReturnType)?) -> ReturnType? {
        switch function  {
        case .some(let functionNotNil): return self.map(functionNotNil)
        case .none: return .none
        }
    }
}
