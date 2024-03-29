//
//  SuspiciousFilesChecker.swift
//
//
//  Created by 0x67 on 2024-03-29.
//

import Foundation

class SuspiciousFilesChecker: Checker {
  private static let suspicousAppandSystemPaths: [String] = [
    "/usr/sbin/frida-server",
    "/etc/apt/sources.list.d/electra.list",
    "/etc/apt/sources.list.d/sileo.sources",
    "/.bootstrapped_electra",
    "/usr/lib/libjailbreak.dylib",
    "/jb/lzma",
    "/.cydia_no_stash",
    "/.installed_unc0ver",
    "/jb/offsets.plist",
    "/usr/share/jailbreak/injectme.plist",
    "/etc/apt/undecimus/undecimus.list",
    "/var/lib/dpkg/info/mobilesubstrate.md5sums",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/jb/jailbreakd.plist",
    "/jb/amfid_payload.dylib",
    "/jb/libjailbreak.dylib",
    "/usr/libexec/cydia/firmware.sh",
    "/var/lib/cydia",
    "/etc/apt",
    "/private/var/lib/apt",
    "/private/var/Users/",
    "/var/log/apt",
    "/Applications/Cydia.app",
    "/private/var/stash",
    "/private/var/lib/apt/",
    "/private/var/lib/cydia",
    "/private/var/cache/apt/",
    "/private/var/log/syslog",
    "/private/var/tmp/cydia.log",
    "/Applications/Icy.app",
    "/Applications/MxTube.app",
    "/Applications/RockApp.app",
    "/Applications/blackra1n.app",
    "/Applications/SBSettings.app",
    "/Applications/FakeCarrier.app",
    "/Applications/WinterBoard.app",
    "/Applications/IntelliScreen.app",
    "/private/var/mobile/Library/SBSettings/Themes",
    "/Library/MobileSubstrate/CydiaSubstrate.dylib",
    "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
    "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
    "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
    "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
    "/Applications/Cydia.app",
    "/Applications/blackra1n.app",
    "/Applications/FakeCarrier.app",
    "/Applications/Icy.app",
    "/Applications/IntelliScreen.app",
    "/Applications/MxTube.app",
    "/Applications/RockApp.app",
    "/Applications/SBSettings.app",
    "/Applications/WinterBoard.app"
  ]
  
  func check() async -> Bool {
    await withTaskGroup(of: Bool.self) { group in
      for path in SuspiciousFilesChecker.suspicousAppandSystemPaths {
        group.addTask {
          return FileManager.default.fileExists(atPath: path)
        }
      }
      
      for await result in group {
        if result {
          return true
        }
      }
      return false
    }
  }
}
