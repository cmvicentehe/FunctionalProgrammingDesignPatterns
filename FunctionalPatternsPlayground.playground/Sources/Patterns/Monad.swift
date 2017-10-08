import Foundation

public class Monad<MonadType>: Functor<MonadType, MonadType> {
    public func flatmap(function: ((MonadType) -> MonadType)) -> MonadType {
        return function(self.value)
    }
}
