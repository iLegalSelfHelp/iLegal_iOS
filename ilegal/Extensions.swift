//
//  Extensions.swift
//  ilegal
//
//  Created by Matthew Rigdon on 3/7/17.
//  Copyright © 2017 Jordan. All rights reserved.
//

import UIKit

extension String {
    var slug: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "_")
    }
}
