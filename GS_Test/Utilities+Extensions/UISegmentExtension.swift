//
//  UISegmentExtension.swift
//  GS_Test
//
//  Created by roshan on 16/06/21.
//

import UIKit

extension UISegmentedControl {
    func replaceSegments(segments: [String]) {
        self.removeAllSegments()
        for segment in segments {
            self.insertSegment(withTitle: segment, at: self.numberOfSegments, animated: true)
        }
        self.selectedSegmentIndex = 0
    }
}
