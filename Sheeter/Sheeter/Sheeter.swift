//
//  Sheeter.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

public typealias SheeterActionHandler = ((String) -> Void)

public final class Sheeter: NSObject {
// MARK: - Properties
	static var xibBundle: Bundle?{
		guard
			let path = Bundle.main.path(forResource: "Frameworks/Sheeter.framework/SheeterBundle", ofType: "bundle"),
			let bundle = Bundle(path: path) else{
			return nil
		}
		return bundle
	}
	
	internal static var nibs: [Any]{
		return xibBundle?.loadNibNamed("Sheeter", owner: nil, options: nil) ?? []
	}
	
	
// MARK: - Override Method
	public static func dimiss(){
		
	}
	
	@discardableResult
	public static func actionSheet(items: [String], handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		return SheeterActionSheet.show(items: items, handler: handler)
	}
	
	@discardableResult
	public static func actionSheet(customView: UIView) -> SheeterViewController?{
		return SheeterActionSheet.show(customView: customView)
	}
	
	@discardableResult
	public static func dropDown(from sender: UIView?,
								items: [String],
								selected index: Int = 0,
								handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		return SheeterDropDown.show(from: sender, items: items, selected: index, handler: handler)
	}
	
	@discardableResult
	public static func dropDown(from sender: UIView?, customView: UIView) -> SheeterViewController?{
		return SheeterDropDown.show(from: sender, customView: customView)
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
