//
//  ViewExtension.swift
//
//  Created by Darkt on 20/1/7.
//  Copyright © 2020 Darkt. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View
{
    func fillScreen() -> some View
    {
        let zero = CGFloat.zero
        let infinity = CGFloat.infinity
        let alignment = Alignment.topLeading
        
        return self.frame(minWidth: zero,
                          maxWidth: infinity,
                          minHeight: zero,
                          maxHeight: infinity,
                          alignment: alignment)
    }
}
