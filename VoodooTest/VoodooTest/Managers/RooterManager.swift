//
//  RooterManager.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit

final class RooterManager: NSObject {
    
    private let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: .main)
    private var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    func todayController() -> UIViewController {
        let todayController = mainStoryboard.instantiateViewController(withIdentifier: TodayListViewController.getIdentifierInStoryboard()) as! TodayListViewController
        todayController.viewModel = TodayListViewModel(rooterManager: self, apiManager: ApiManager.shared)
        return todayController
    }
        
    func showDetailView(application: Application, identifier: TodayIdentifierCell, originalFrame: CGRect) {
        let todayDetailView = mainStoryboard.instantiateViewController(withIdentifier: TodayDetailViewController.getIdentifierInStoryboard()) as! TodayDetailViewController
        todayDetailView.viewModel = TodayDetailViewModel(application: application, identifier: identifier, originalFrame: originalFrame)
        todayDetailView.transitioningDelegate = todayDetailView
        todayDetailView.modalPresentationStyle = .overFullScreen
        todayDetailView.modalPresentationCapturesStatusBarAppearance = true
        window?.rootViewController?.present(todayDetailView, animated: true, completion: nil)
    }
    
    func showProfilView() {
        let profilView = mainStoryboard.instantiateViewController(withIdentifier: ProfilViewController.getIdentifierInStoryboard())
        window?.rootViewController?.present(profilView, animated: true, completion: nil)
    }
    
}
