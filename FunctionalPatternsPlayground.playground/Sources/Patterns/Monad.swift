import Foundation

public protocol Monad: Functor {
    //MARK: Types
    associatedtype MonadType
    
    func flatmap(function: ((MonadType) -> MonadType)) -> MonadType
}
