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
		Sheeter.actionSheet(customView: actionCollectionVC.view)
	}

	@IBAction func dropDownCustom(_ sender: UIButton) {
		Sheeter.dropDown(from: sender, customView: actionCollectionVC.view)
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
	
	fileprivate var actionCollectionVC: ActionCollectionVC{
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
		vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
		vc.collectionView?.delegate = self
		return vc
	}
}

extension ViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("You clicked Action Item \(indexPath.item)")
	}
}

