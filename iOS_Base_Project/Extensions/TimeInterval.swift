//
//  TimeInterval.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/31/21.
//

import Foundation

extension TimeInterval {
    func timeString() -> String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }

    func timeWithSymbolString() -> String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60
        return String(format: "%ih %im %is", hour, minute, second)
    }
}
