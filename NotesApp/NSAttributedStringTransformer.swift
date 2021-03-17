//
//  NSAttributedStringTransformer.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import Foundation

import UIKit
import CoreData

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
		override class var allowedTopLevelClasses: [AnyClass] {
				return super.allowedTopLevelClasses + [NSAttributedString.self]
		}
}
