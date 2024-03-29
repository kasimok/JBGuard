//
//  main.swift
//  hackMe
//
//  Created by 0x67 on 2024-03-29.
//

import Foundation
import UIKit
import disable_attach

autoreleasepool {
  #if !DEBUG
  disable_gdb()
  #endif
  let _ = UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(AppDelegate.self)
  )
}
