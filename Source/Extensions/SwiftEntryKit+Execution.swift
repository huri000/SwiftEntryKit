//
//  EKExecution.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/8/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

extension SwiftEntryKit {
    
    /**
     Executes a UI action on the main thread, thus letting any of the class methods of SwiftEntryKit to be invokes even from a background thread.
     */
    static func execute(action: @escaping () -> ()) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}


