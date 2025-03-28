/*
 * Copyright (c) 2023 European Commission
 *
 * Licensed under the EUPL, Version 1.2 or - as soon they will be approved by the European
 * Commission - subsequent versions of the EUPL (the "Licence"); You may not use this work
 * except in compliance with the Licence.
 *
 * You may obtain a copy of the Licence at:
 * https://joinup.ec.europa.eu/software/page/eupl
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the Licence is distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the Licence for the specific language
 * governing permissions and limitations under the Licence.
 */
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import CopyableMacro

final class TestCopyableMacro: XCTestCase {
  
  func testExpansion_WhenVisibilityIsInternalAndNoOptionals_ThenAssertResult() {
    assertMacroExpansion(
            """
            @Copyable
            struct User {
                let name: String
                let age: Int
            }
            """,
            expandedSource: """
            struct User {
                let name: String
                let age: Int
            
                /// Returns a copy of the caller whose value for `name` is different.
                internal func copy(name: String) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose value for `age` is different.
                internal func copy(age: Int) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose values are different. All values are optional and the previous value will be used if not set.
                internal func copy(name: String? = nil, age: Int? = nil) -> Self {
                    .init(name: name ?? self.name, age: age ?? self.age)
                }
            }
            """,
            macros: ["Copyable": CopyableMacro.self]
    )
  }
  
  func testExpansion_WhenVisibilityIsPublicAndNoOptionals_ThenAssertResult() {
    assertMacroExpansion(
            """
            @Copyable
            public struct User {
                public let name: String
                public let age: Int
            }
            """,
            expandedSource: """
            public struct User {
                public let name: String
                public let age: Int
            
                /// Returns a copy of the caller whose value for `name` is different.
                public func copy(name: String) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose value for `age` is different.
                public func copy(age: Int) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose values are different. All values are optional and the previous value will be used if not set.
                public func copy(name: String? = nil, age: Int? = nil) -> Self {
                    .init(name: name ?? self.name, age: age ?? self.age)
                }
            }
            """,
            macros: ["Copyable": CopyableMacro.self]
    )
  }
  
  func testExpansion_WhenVisibilityIsInternalWithOptionals_ThenAssertResult() {
    assertMacroExpansion(
            """
            @Copyable
            struct User {
                let name: String
                let age: Int?
            }
            """,
            expandedSource: """
            struct User {
                let name: String
                let age: Int?
            
                /// Returns a copy of the caller whose value for `name` is different.
                internal func copy(name: String) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose value for `age` is different.
                internal func copy(age: Int?) -> Self {
                    .init(name: name, age: age)
                }
            
                /// Returns a copy of the caller whose values are different. All values are optional and the previous value will be used if not set.
                internal func copy(name: String? = nil, age: Int? = nil) -> Self {
                    .init(name: name ?? self.name, age: age ?? self.age)
                }
            }
            """,
            macros: ["Copyable": CopyableMacro.self]
    )
  }
}
