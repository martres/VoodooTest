//
//  TodayDetailViewModel.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit

protocol TodayDetailViewModelInterface {
    func getIdentifier() -> TodayIdentifierCell
    func getOriginalFrame() -> CGRect
    func getApplication() -> Application
}

final class TodayDetailViewModel: NSObject {
    
    private let application: Application
    private let identifier: TodayIdentifierCell
    private let originalFrame: CGRect
    
    init(application: Application,
         identifier: TodayIdentifierCell,
         originalFrame: CGRect) {
        self.application = application
        self.identifier = identifier
        self.originalFrame = originalFrame
    }
}

// MARK: TodayDetailViewModelInterface

extension TodayDetailViewModel: TodayDetailViewModelInterface {
    func getOriginalFrame() -> CGRect {
        return originalFrame
    }
    
    func getApplication() -> Application {
        return application
    }
    
    func getIdentifier() -> TodayIdentifierCell {
        return identifier
    }

}
