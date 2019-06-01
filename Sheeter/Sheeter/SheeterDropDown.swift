//
//  SheeterDropDown.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

class SheeterDropDown: SheeterViewController {

// MARK: - IBOutlets

// MARK: - Properties
	private var wrapperViewHeight: CGFloat = 0
	
	var selectedIndex: Int = -1
	
	var sender: UIView?{
		didSet{
			if let view = sender {
				let p = CGPoint(x: 0, y: view.frame.maxY)
				animateConstraint.constant = view.superview!.convert(p, to: self.view).y - UIApplication.shared.statusBarFrame.height
			}
		}
	}
	
	override class var nibViewController: SheeterViewController?{
		return Sheeter.nibs.first as? SheeterDropDown
	}
	
// MARK: - Initial Method
    
// MARK: - Lifecycle Method
    
// MARK: - Action & IBOutletAction

// MARK: - Override Method
	override func initialSetup(contentView: UIView, constraint constant: CGFloat) {
		super.initialSetup(contentView: contentView, constraint: constant)
		
		wrapperViewHeightConstraint.constant = 0
		wrapperViewHeight = constant
	}
	
    override func animate(isShowing: Bool, completion: (() -> Void)?) {
		let value: CGFloat = isShowing
			? wrapperViewHeight
			: 0
		wrapperViewHeightConstraint.constant = value
		UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
			self.view.layoutIfNeeded()
		}) { _ in
			completion?()
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
		cell.textLabel?.textAlignment = .left
		cell.accessoryType = indexPath.row == selectedIndex
			? .checkmark
			: .none
		
		return cell
	}

// MARK: - Private Method

// MARK: - Public Method
	@discardableResult
	static func show(from sender: UIView?,
					 items: [String],
					 selected index: Int,
					 handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		let vc = super.show(items: items, handler: handler) as? SheeterDropDown
		vc?.sender = sender
		vc?.selectedIndex = index
		return vc
	}
	
	@discardableResult
	static func show(from sender: UIView?, customView: UIView) -> SheeterViewController?{
		let vc = super.show(customView: customView) as? SheeterDropDown
		vc?.sender = sender
		return vc
	}
}
