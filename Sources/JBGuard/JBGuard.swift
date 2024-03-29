import Foundation
import Darwin
#if os(iOS) || os(tvOS)
/// Simple Jail Break Detection Methods, this methods can be accessed, reverse-engineered and evaded by attackers
public struct DetectionKind: OptionSet {
  public let rawValue: Int
  
  public static let jailbreakFiles = DetectionKind(rawValue: 1 << 0)
  public static let sandbox = DetectionKind(rawValue: 1 << 1)
  public static let cydiaSchema = DetectionKind(rawValue: 1 << 2)
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}


protocol Checker {
  func check() async -> Bool
}


class CheckerFactory {
  static func createCheckers(for detectionKinds: DetectionKind) -> [Checker] {
    var checkers = [Checker]()
    
    if detectionKinds.contains(.jailbreakFiles) {
      checkers.append(SuspiciousFilesChecker())
    }
    
    if detectionKinds.contains(.sandbox) {
      checkers.append(OutOfSandboxWriteChecker())
    }
    
    if detectionKinds.contains(.cydiaSchema) {
      checkers.append(SchemaChecker())
    }
    
    return checkers
  }
}



public struct JBGuard {
  
  public init() {}
  
  /// Detect if device is jailbreaked
  /// - Parameter kind: detection kind, use at your with
  /// - Returns: `true` if device is jailbreaked
  public func detecteJailBreak(of kind: DetectionKind) async -> Bool {
    let checkers = CheckerFactory.createCheckers(for: kind)
    var jailbreakDetected = false
    
    await withTaskGroup(of: Bool.self) { group in
      for checker in checkers {
        group.addTask {
          return await checker.check()
        }
      }
      
      for await result in group {
        if result {
          jailbreakDetected = true
          break
        }
      }
    }
    
    return jailbreakDetected
  }
}
#endif
