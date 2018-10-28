//
//  TodayListViewModel.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit

protocol TodayListViewModelInterface {
    func getNumberOfSection() -> Int
    func getNumberOfRows(in section: Int) -> Int
    func getRandomCellIdentifier() -> String
    func getApplication(at indexPath: IndexPath) -> Application?
    func showDetail(for indexPath: IndexPath, identifier: TodayIdentifierCell, originalFrame: CGRect)
    func showProfil()
    
    var delegate: TodayListViewModelDelegate? { get set }
}

protocol TodayListViewModelDelegate: class {
    func receivedData()
}

enum TodayIdentifierCell: String, CaseIterable {
    case top = "TodayTop"
    case bottom = "TodayBottom"

    // Need to be modify in switch if more case
    init(value: Int) {
        self = value == 0 ? .top :.bottom
    }
}

final class TodayListViewModel: NSObject, TodayListViewModelInterface {
    
    private let rooterManager: RooterManager
    private let apiManager: ApiManager
    
    private var apps: [Application]? {
        didSet {
            delegate?.receivedData()
        }
    }
    
    var delegate: TodayListViewModelDelegate? {
        didSet {
            getBestApps()
        }
    }
    
    init(rooterManager: RooterManager,
         apiManager: ApiManager) {
        self.rooterManager = rooterManager
        self.apiManager = apiManager
    }
    
    private func getBestApps() {
        apiManager.getBestApps { [weak self] (apps, error) in
            guard let strongSelf = self else { return }
            guard let apps = apps else { return }
            
            strongSelf.apps = apps
        }
    }
    
}

// MARK: TodayListViewModelInterface

extension TodayListViewModel {
    
    func getRandomCellIdentifier() -> String {
        let randomValue = Int.random(in: 0..<TodayIdentifierCell.allCases.count)
        return TodayIdentifierCell(value: randomValue).rawValue
    }
    
    func getNumberOfSection() -> Int {
        return 1
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        return apps?.count ?? 0
    }
    
    func getApplication(at indexPath: IndexPath) -> Application? {
        return apps?[indexPath.item]
    }
    
    func showDetail(for indexPath: IndexPath, identifier: TodayIdentifierCell, originalFrame: CGRect) {
        guard let app = getApplication(at: indexPath) else { return }
        rooterManager.showDetailView(application: app, identifier: identifier, originalFrame: originalFrame)
    }
    
    func showProfil() {
        rooterManager.showProfilView()
    }
}
