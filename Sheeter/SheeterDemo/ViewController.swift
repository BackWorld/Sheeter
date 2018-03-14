//
//  ViewController.swift
//  SheeterDemo
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit
import Sheeter

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBAction func actionSheet(_ sender: Any) {
		Sheeter.actionSheet(items: [
			"Action Sheet Item1",
			"Action Sheet Item2"])
		{ (selected) in
			print(selected)
		}
	}
	
	@IBAction func actionSheetCustom(_ sender: Any) {
		let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 0)))
		label.numberOfLines = 0
		label.text = "Custom Action Sheet Content View"
		label.font = UIFont.systemFont(ofSize: 30)
		label.sizeToFit()
		Sheeter.actionSheet(customView: label)
	}

	@IBAction func dropDownCustom(_ sender: UIButton) {
		let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 0)))
		label.numberOfLines = 0
		label.text = "Custom Drop Down Content View"
		label.font = UIFont.systemFont(ofSize: 30)
		label.sizeToFit()
		Sheeter.dropDown(from: sender, customView: label)
	}
	
	@IBAction func dropDown(_ sender: UIButton) {
		Sheeter.dropDown(from: sender, items: [
			"Drop Down Item1",
			"Drop Down Item2",
			"Drop Down Item3"
		]) { (selected) in
			print(selected)
		}
	}
}

