//
//  String.swift
//  MyTravelHelper
//
//  Created by Rahul Gera on 24/05/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation

extension String {
    
    func caseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return lowercased().starts(with: prefix.lowercased())
    }
    
}
