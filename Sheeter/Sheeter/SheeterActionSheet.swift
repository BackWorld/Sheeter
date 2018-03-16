//
//  SheeterActionSheet.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

class SheeterActionSheet: SheeterViewController {

// MARK: - IBOutlets
	@IBOutlet weak var cancelButton: UIButton!

// MARK: - Properties
	override class var nibViewController: SheeterViewController?{
		return Sheeter.nibs.last as? SheeterActionSheet
	}
	
	override var appearance: Sheeter.Appearance{
		didSet{
			super.appearance = appearance
			cancelButton.layer.cornerRadius = appearance.cornerRadius
		}
	}
	
// MARK: - Initial Method
    
// MARK: - Lifecycle Method

// MARK: - Action & IBOutletAction
	 @IBAction func cancel(_ sender: UIButton) {
		dismiss()
	 }

// MARK: - Override Method
	override func initialSetup(contentView: UIView, constraint constant: CGFloat) {
		super.initialSetup(contentView: contentView, constraint: constant)
		
		wrapperViewHeightConstraint.constant = constant
	}

// MARK: - Private Method

// MARK: - Public Method
	override func animate(isShowing: Bool, completion: ((Void) -> Void)?) {
		let value: CGFloat = isShowing
			? appearance.margin
			: -(wrapperViewHeightConstraint.constant + cancelButton.bounds.height + 10)
		animateConstraint.constant = value
		UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
			self.view.layoutIfNeeded()
		}) { _ in
			completion?()
		}
	}
}
