//
//  TodayListViewController.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

class TodayListViewController: UIViewController {
    
    @IBOutlet private weak var todayCollectionView: UICollectionView!

    var viewModel: TodayListViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "View Model shouldn't be nil")
        viewModel.delegate = self
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        
        // Header
        let nibHeader = UINib(nibName: TodayHeaderCollectionReusableView.identifier, bundle: .main)
        todayCollectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: TodayHeaderCollectionReusableView.identifier)
        
        // Cells
        let nibTodayTop = UINib(nibName: "TodayTop", bundle: .main)
        let nibTodayBottom = UINib(nibName: "TodayBottom", bundle: .main)
        todayCollectionView.register(nibTodayTop, forCellWithReuseIdentifier: "TodayTop")
        todayCollectionView.register(nibTodayBottom, forCellWithReuseIdentifier: "TodayBottom")
        
    }
}

// MARK: UICollectionViewDelegate

extension TodayListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let collectionIdentifier = collectionView.cellForItem(at: indexPath)?.reuseIdentifier else { return }
        guard let identifier = TodayIdentifierCell(rawValue: collectionIdentifier) else { return }
        let attributes: UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrameInSuperview: CGRect! = collectionView.convert(attributes.frame, to: collectionView.superview)
        viewModel.showDetail(for: indexPath, identifier: identifier, originalFrame: cellFrameInSuperview)
    }
    
}

// MARK: UICollectionViewFlowLayout

extension TodayListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 40 , height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 75)
    }
    
}

// MARK: UICollectionViewDataSource

extension TodayListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayHeaderCollectionReusableView.identifier, for: indexPath) as! TodayHeaderCollectionReusableView
            headerView.delegate = self
            return headerView
        default: break
        }
        fatalError("Unexpected element kind")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getNumberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = viewModel.getRandomCellIdentifier()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TodayCell else {
            fatalError("Cell is unknown")
        }
        if let application = viewModel.getApplication(at: indexPath) {
            cell.setup(app: application)
        }
        return cell
    }
    
}

// MARK: TodayListViewModelDelegate

extension TodayListViewController: TodayListViewModelDelegate {
    
    func receivedData() {
        DispatchQueue.main.async {
            self.todayCollectionView.reloadData()
        }
    }
    
}

// MARK: TodayHeaderDelegate

extension TodayListViewController: TodayHeaderDelegate {
    func showProfilView() {
        viewModel.showProfil()
    }
}
