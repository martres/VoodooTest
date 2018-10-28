//
//  TodayDetailViewController.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

class TodayDetailViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    
    @IBOutlet private weak var topConstraintCard: NSLayoutConstraint!
    @IBOutlet private weak var heightConstraintCard: NSLayoutConstraint!
    @IBOutlet private weak var widthConstraintCard: NSLayoutConstraint!

    
    var viewModel: TodayDetailViewModelInterface!
    private var todayView: TodayView!
    private var gestureScrollView: UIPanGestureRecognizer!
    let animator = TodayAnimator()
    
    // MARK: StatusBar
    
    var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 1) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    // MARK: View loader
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "View model shouldn't be nil")
        setupTodayView()
        updateConstraintsScrollView(frame: viewModel.getOriginalFrame())
        
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    private func setupTodayView() {
        todayView = TodayCell.instance(with: viewModel.getIdentifier()) as? TodayView
        todayView.setup(app: viewModel.getApplication())
        todayView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(todayView)
        NSLayoutConstraint.activate([
            todayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            todayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            todayView.bottomAnchor.constraint(equalTo: containerView .bottomAnchor)
            ])
        gestureScrollView = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        containerView.addGestureRecognizer(gestureScrollView)
    }
    
    // MARK: Selectors
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            dismiss()
        default:
            break
        }
    }
    
    // MARK: IBAction
    
    @IBAction private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Animation
    
    private func updateConstraintsScrollView(frame: CGRect) {
        heightConstraintCard.constant = frame.height
        topConstraintCard.constant = frame.origin.y
        widthConstraintCard.constant = frame.width
        view.layoutIfNeeded()
    }
    
    internal func willPresentView() {
        statusBarHidden = true
        todayView.setCorner(value: 0)
        updateConstraintsScrollView(frame: view.frame)
        closeButton.alpha = 0.7
    }
    
    internal func willDismissView() {
        statusBarHidden = false
        todayView.setCorner(value: 10)
        updateConstraintsScrollView(frame: viewModel.getOriginalFrame())
        closeButton.alpha = 0
    }
    
}

// MARK: UIViewControllerTransitioningDelegate

extension TodayDetailViewController: UIViewControllerTransitioningDelegate {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in

        }, completion: nil)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = false
        return animator
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.initialFrame = viewModel.getOriginalFrame()
        animator.isPresenting = true
        return animator
    }
    
}
