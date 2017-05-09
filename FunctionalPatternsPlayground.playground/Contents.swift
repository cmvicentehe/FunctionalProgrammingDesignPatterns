//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let user1 = User(name: "User 1", lastName: "LastName 1")
let user2 = User(name: "User 2", lastName: "LastName 2")
let user3 = User(name: "User 3", lastName: "LastName 3")
let user4 = User(name: "User 4", lastName: "LastName 4")

let users: [User] = [user1, user2, user3, user4]
let usersTransformed = users.map(Helpers.usersTransformation)

// MAYBE with value

let maybeExampleValue: MaybeInteger = MaybeInteger(value: .just(3))
let resultValue: Int? = maybeExampleValue.map(function: Helpers.checkNilInteger)

// MAYBE nil

let maybeExampleNil: MaybeInteger = MaybeInteger(value: .nothing)
let resultValueNil: Int? = maybeExampleNil.map(function: Helpers.checkNilInteger)


// MAYBE As a Monad with value

let maybeMonadExampleValue: MaybeInteger = MaybeInteger(value: .just(3))
let monadResultValue: Maybe<Int> = maybeExampleValue.flatmap(function: Helpers.checkMaybeInteger)

print(monadResultValue)

// MAYBE As a Monad without value

let maybeMonadExampleWithoutValue: MaybeInteger = MaybeInteger(value: .nothing)
let monadResultWithoutValue: Maybe<Int> = maybeMonadExampleWithoutValue.flatmap(function: Helpers.checkMaybeInteger)

print(monadResultWithoutValue)

// Typeclass
let resultByFive = Helpers.timesByFour(addable: 5)
let resultByHello = Helpers.timesByFour(addable: "hello")

// Applicative with function nil
let optionalIntWithValue: Optional<Int> = .some(3)
let optionalApplicativeResult:Optional<Int> = optionalIntWithValue.apply(function: nil)

// Applicative with function not nil
let otherOptionalIntWithValue: Optional<Int> = .some(8)
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
let futureExample: Future<UserWithAvatar, DownloadError> = Helpers.requestUserInfo(userId: "swift")

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

