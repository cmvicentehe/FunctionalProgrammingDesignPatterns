//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let user1 = User(name: "User 1", lastName: "LastName 1")
let user2 = User(name: "User 2", lastName: "LastName 2")
let user3 = User(name: "User 3", lastName: "LastName 3")
let user4 = User(name: "User 4", lastName: "LastName 4")

let functor1: Functor<User, String> = Functor(value: user1)
let functor2: Functor<User, String> = Functor(value: user2)
let functor3: Functor<User, String> = Functor(value: user3)
let functor4: Functor<User, String> = Functor(value: user4)

let functorUsers: [Functor<User, String>] = [functor1, functor2, functor3, functor4]
let usersTransformed = functorUsers.map(Helpers.usersTransformation)

print("users transformed: \(usersTransformed)")

//// MAYBE with value
let maybeThree = Maybe.just(3)
let maybeAsAFunctor: Functor<Maybe<Int>, Maybe<Int>> = Functor(value: maybeThree)
let maybeThreeResult = maybeAsAFunctor.map(function: Helpers.checkMaybeInteger)
print("Maybe result = \(maybeThreeResult)")

//// MAYBE nil
let maybeNothing: Maybe<Int> = Maybe.nothing
let maybeNothingAsAFunctor: Functor<Maybe<Int>, Int?> = Functor(value: maybeNothing)
let maybeNothingResult = maybeNothingAsAFunctor.map(function: Helpers.checkNilInteger)
print("Maybe result = \(String(describing: maybeNothingResult))")

// MAYBE As a Monad with value

let maybeMonadExampleThree: Monad<Maybe<Int>> = Monad(value: maybeThree)
let monadThreeResultValue: Maybe<Int> = maybeMonadExampleThree.flatmap(function: Helpers.checkMaybeInteger)
print("Monad maybe result = \(monadThreeResultValue)")

// MAYBE As a Monad without value

let maybeMonadExampleNothing: Monad<Maybe<Int>> = Monad(value: maybeNothing)
let monadNothingResultValue: Maybe<Int> = maybeMonadExampleNothing.flatmap(function: Helpers.checkMaybeInteger)
print("Monad maybe result = \(monadNothingResultValue)")


// Typeclass
let resultByFive = Helpers.timesByFour(addable: 5)
let resultByHello = Helpers.timesByFour(addable: "hello")

// Applicative with function nil
let optionalIntWithValue: Optional<Int> = .some(3)
let optionalApplicativeResult:Optional<Int> = optionalIntWithValue.apply(function: nil)

// Applicative with function not nil
let otherOptionalIntWithValue: Optional<Int> = .none
let optionalApplicativeResultWithValue: Optional<Int> = otherOptionalIntWithValue.apply(function: Helpers.functionToTestApplicative)

// READER
let test = Environment(path: "path_to_sqlite")
let production = Environment(path: "path_to_realm")
let carTest = Helpers.updateCarModel(model: "M5", newModel: "M3").apply(environment: test)
let carProduction = Helpers.updateCarModel(model: "M5", newModel: "Serie1").apply(environment: production)

let reader = Helpers.updateCarModel(model: "Serie1", newModel: "M3").map(function: Helpers.brandForCar).apply(environment: test)

let readerExample = Reader<Environment, Car>(transform: Helpers.carTransform).map(function: Helpers.brandForCar)
let model = readerExample.apply(environment: test)

// FUTURE
let futureExample: Future<UserWithAvatar, DownloadError> = Helpers.requestUserInfo(userId: "notExistent")

futureExample.start() { result in
    switch result {
        case .success(let image):
            image.value
        case .error(let error):
            error
        }
    print(result.debugDescription)
}

let avatarFuture = Helpers.loadAvatar(userId: "swift")

avatarFuture.start() { result in
    switch result {
        case .success(let image):
            image.value
        case .error(let error):
            error
        }
    
    print(result.debugDescription)
}

let avatarError = Helpers.loadAvatar(userId: "invalid").mapError { _ in
    return NSError(domain: "MyErrorDomain", code: 3, userInfo: nil)
}

avatarError.start() { result in
    switch result {
    case .success(let image):
            image.value
        case .error(let error):
            error
    }
    
    print(result.debugDescription)
}

