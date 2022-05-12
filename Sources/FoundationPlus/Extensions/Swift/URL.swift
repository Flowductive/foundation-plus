//
//  URL.swift
//  
//
//  Created by Ben Myers on 5/12/22.
//

import Foundation

#if os(iOS)
import UIKit
#else
import AppKit
#endif

public extension URL {
  
  // MARK: - Public Methods
  
  func open() {
    #if os(iOS)
    UIApplication.shared.open(self)
    #else
    NSWorkspace.shared.open(self)
    #endif
  }
}
