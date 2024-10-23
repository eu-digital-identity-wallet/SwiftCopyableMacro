# SwiftCopyableMacro

A Swift Macro for Kotlin like copy() for Structs.

## How to use

Installation

```
.package(
  url: "https://github.com/eu-digital-identity-wallet/SwiftCopyableMacro.git",
  from: "0.0.1"
)
```

```
targets: [
  .target(
    name: "ExampleProject",
    dependencies: [
      .product(
        name: "Copyable",
        package: "SwiftCopyableMacro"
      )
    ]
  )
]
```

Usage

```
@Copyable
struct Dog {
  let name: String
  let age: Int
}
```

```
let dog = Dog(name: "Fido", age: 5)
let simpleCopy = dog.copy(name: "Pablo")
let chainedCopy = dog.copy(name: "Nobet").copy(age: 11)
let combinedCopy = dog.copy(name: "Rex", age: 2)
```
