//
//  AlertModel.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 28/2/22.
//

import Foundation
import SwiftUI

class AlertModel: ObservableObject {
    @Published var isShowing = false
    @Published var title: String?
    @Published var message: String?
    @Published var buttonTitle: String?
    @Published var action: (() -> Void)?
    
    init(isShowing: Bool = false, error: Error? = nil, action: (() -> Void)? = nil) {
        if let error = error {
            self.title = "Error"
            self.message = error.localizedDescription
        }
        self.isShowing = isShowing
        self.buttonTitle = "dismiss"
        self.action = action
    }

}
