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
import SwiftSyntax
import SwiftDiagnostics

enum CopyableDiagnostic: DiagnosticMessage {

  case notAStruct
  case propertyTypeProblem(PatternBindingListSyntax.Element)

  var severity: DiagnosticSeverity {
    switch self {
    case .notAStruct: .error
    case .propertyTypeProblem: .warning
    }
  }

  var message: String {
    switch self {
    case .notAStruct:
      "'@Copyable' can only be applied to a 'struct'"
    case .propertyTypeProblem(let binding):
      "Type error for property '\(binding.pattern)': \(binding)"
    }
  }

  var diagnosticID: MessageID {
    switch self {
    case .notAStruct:
        .init(domain: "CopyableMacros", id: "notAStruct")
    case .propertyTypeProblem(let binding):
        .init(domain: "CopyableMacros", id: "propertyTypeProblem(\(binding.pattern))")
    }
  }
}
