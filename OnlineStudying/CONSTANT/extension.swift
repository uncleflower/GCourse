//
//  extention.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/5/30.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import Foundation

extension String {
    var isBlank:Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}
