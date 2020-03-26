//
//  StringEx.swift
//  DReversi
//
//  Created by DIO on 2019/12/14.
//  Copyright © 2019 DIO. All rights reserved.
//

import UIKit

extension String {
    public func stringAtIndex(index: Int) -> String? {
        if self.isIndexOutOfRange(index: index) { return nil }
        let subString: Substring = self[self.index(self.startIndex, offsetBy: index) ..< self.index(self.startIndex, offsetBy: index + 1)]
        return String(subString)
    }
    
    private func isIndexOutOfRange(index: Int) -> Bool {
        return (0 > index || index >= self.count)
    }
}
