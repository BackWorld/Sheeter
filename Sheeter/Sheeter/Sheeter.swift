//
//  Sheeter.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

public typealias SheeterActionHandler = ((Int) -> Void)

public final class Sheeter: NSObject {
// MARK: - Properties
	public final class Appearance{
		public static let `default` = Appearance()
		
		public var fontSize: CGFloat = 14
		public var margin: CGFloat = 0
		public var cornerRadius: CGFloat = 0
	}
	
	static var nibs: [Any]{
		return Bundle.main.loadNibNamed("Frameworks/Sheeter.framework/Sheeter", owner: nil, options: nil) ?? []
	}
	
	
// MARK: - Override Method
	public static func dimiss(){
		
	}
	
	@discardableResult
	public static func actionSheet(items: [String],
	                               appearance: Appearance = .default,
	                               handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		let vc = SheeterActionSheet.show(items: items, handler: handler)
		vc?.appearance = appearance
		return vc
	}
	
	@discardableResult
	public static func actionSheet(customView: UIView,
	                               appearance: Appearance = .default) -> SheeterViewController?{
		let vc = SheeterActionSheet.show(customView: customView)
		vc?.appearance = appearance
		return vc
	}
	
	@discardableResult
	public static func dropDown(from sender: UIView?,
								items: [String],
								selected index: Int = 0,
								appearance: Appearance = .default,
								handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		let vc = SheeterDropDown.show(from: sender, items: items, selected: index, handler: handler)
		vc?.appearance = appearance
		return vc
	}
	
	@discardableResult
	public static func dropDown(from sender: UIView?,
	                            customView: UIView,
	                            appearance: Appearance = .default) -> SheeterViewController?{
		let vc = SheeterDropDown.show(from: sender, customView: customView)
		vc?.appearance = appearance
		return vc
	}
}

internal extension Sheeter{
	static func holderViewController(for view: UIView) -> UIViewController? {
		weak var parentResponder: UIResponder? = view
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}
	
	static var topViewControllerOfApplicationKeyWindow: UIViewController? {
		var vc = topViewController(of: UIApplication.shared.keyWindow?.rootViewController)
		while vc?.presentedViewController != nil {
			vc = topViewController(of: vc?.presentedViewController)
		}
		return topViewController(of: vc)
	}
	
	 static func topViewController(of parentViewController: UIViewController?) -> UIViewController?{
		if let nav = parentViewController as? UINavigationController {
			return nav.topViewController
		}
		if let tab = parentViewController as? UITabBarController {
			return tab.selectedViewController
		}
		return parentViewController
	}
}
