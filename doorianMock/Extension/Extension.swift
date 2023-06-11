//
//  Extension.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 29/3/2566 BE.
//

import Foundation
import SwiftUI

public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
