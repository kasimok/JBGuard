//
//  SchemaChecker.swift
//
//
//  Created by 0x67 on 2024-03-29.
//
#if os(iOS)
import Foundation
import UIKit

class SchemaChecker: Checker {
  
  static let schemas = ["cydia://package/com.example.package"]
  func check() async -> Bool {
    await withTaskGroup(of: Bool.self) { group in
      for schema in SchemaChecker.schemas {
        
        group.addTask {
          if let url = URL(string: schema), await UIApplication.shared.canOpenURL(url) {
            return true
          }else {
            return false
          }
        }
        
        for await result in group {
          if result {
            return true
          }
        }
      }
      return false
    }
  }
}
#endif
