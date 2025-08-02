/*
 * Copyright (c) 2025 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

#if canImport(CopyablePlugin)
@testable import CopyablePlugin

let testMacros: [String: Macro.Type] = [
  "Copyable": CopyableMacro.self
]
#endif

final class TestCopyableMacro: XCTestCase {
  
  func testExpansion_WhenVisibilityIsInternalAndNoOptionals_ThenAssertResult() throws {
#if canImport(CopyablePlugin)
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
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testExpansion_WhenVisibilityIsInternalAndNoOptionalsAndThereIsAStaticToken_ThenAssertResult() throws {
#if canImport(CopyablePlugin)
    assertMacroExpansion(
            """
            @Copyable
            struct User {
                static let type: String = "Registered"
                let name: String
                let age: Int
            }
            """,
            expandedSource: """
            struct User {
                static let type: String = "Registered"
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
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testExpansion_WhenVisibilityIsPublicAndNoOptionals_ThenAssertResult() throws {
#if canImport(CopyablePlugin)
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
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
  
  func testExpansion_WhenVisibilityIsInternalWithOptionals_ThenAssertResult() throws {
#if canImport(CopyablePlugin)
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
            macros: testMacros
    )
#else
    throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
  }
}
