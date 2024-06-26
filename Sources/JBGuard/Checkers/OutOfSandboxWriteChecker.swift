//
//  File.swift
//
//
//  Created by 0x67 on 2024-03-29.
//
#if os(iOS) || os(tvOS)
import Foundation

class OutOfSandboxWriteChecker: Checker {
  func checkSync() -> Bool {
    do {
      let pathToFileInRestrictedDirectory = "/private/jailbreak.txt"
      try "This is a test.".write(toFile: pathToFileInRestrictedDirectory, atomically: true, encoding: String.Encoding.utf8)
      try FileManager.default.removeItem(atPath: pathToFileInRestrictedDirectory)
      // If the write operation was successful, then the device is jailbroken
      return true
    } catch {
      // If the write operation failed, then the device is not jailbroken
      return false
    }
  }
  
  func check() async -> Bool {
    checkSync()
  }
}
#endif
