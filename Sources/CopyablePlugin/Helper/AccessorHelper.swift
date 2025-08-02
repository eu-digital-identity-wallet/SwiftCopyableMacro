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

func accessorIsAllowed(_ accessor: AccessorBlockSyntax.Accessors?) -> Bool {

  guard let accessor else { return true }

  return switch accessor {
  case .accessors(let accessorDeclListSyntax):
    !accessorDeclListSyntax.contains {
      $0.accessorSpecifier.text == "get" || $0.accessorSpecifier.text == "set"
    }
  case .getter:
    false
  }
}
