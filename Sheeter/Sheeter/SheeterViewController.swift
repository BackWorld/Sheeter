//
//  SheeterViewController.swift
//  Sheeter
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 GuessMe. All rights reserved.
//

import UIKit

public class SheeterViewController: UIViewController {
// MARK: - IBOutlets
	@IBOutlet weak var wrapperView: UIView!
	@IBOutlet weak var wrapperViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var wrapperViewTrailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var wrapperViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var animateConstraint: NSLayoutConstraint!
	
	fileprivate lazy var defaultContentView: UITableView = {
		let tb: UITableView = UITableView()
		tb.dataSource = self
		tb.delegate = self
		tb.separatorInset = .zero
		return tb
	}()
	
// MARK: - Properties
	class var nibViewController: SheeterViewController?{
		return nil
	}
	
	let defaultItemHeight: CGFloat = 44
	
	var customView: UIView? = nil{
		didSet{
			guard let view = customView else{
				return
			}
			initialSetup(contentView: view, constraint: view.bounds.height)
			if let vc = Sheeter.holderViewController(for: view){
				addChildViewController(vc)
			}
		}
	}
	var items: [String] = []{
		didSet{
			initialSetup(contentView: defaultContentView, constraint: CGFloat(items.count) * defaultItemHeight)
		}
	}
	var handler: SheeterActionHandler? = nil
	
	var appearance: Sheeter.Appearance = .default{
		didSet{
			wrapperViewLeadingConstraint.constant = appearance.margin
			wrapperViewTrailingConstraint.constant = appearance.margin
			wrapperView.layer.cornerRadius = appearance.cornerRadius
		}
	}
	
// MARK: - Initial Method
	private func setupUI() {
		modalPresentationStyle = .overCurrentContext
		view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
	}
	
	private func initData() {
		
	}
	
	
// MARK: - Lifecycle Method
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		
		initData()
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		animate(isShowing: true, completion: nil)
	}
	
// MARK: - Action & IBOutletAction
	
// MARK: - Override Method
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		dismiss()
	}
	
// MARK: - Private Method
	func show(){
		var vc = Sheeter.topViewControllerOfApplicationKeyWindow
		if let isHidden = vc?.tabBarController?.tabBar.isHidden,
			!isHidden {
			vc = vc?.tabBarController
		}
		vc?.present(self, animated: false, completion: nil)
	}
	
	func initialSetup(contentView: UIView, constraint constant: CGFloat){
		contentView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.addSubview(contentView)
		
		contentView.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
		contentView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
		animate(isShowing: false, completion: nil)
	}
	
// MARK: - Public Method
	func dismiss(){
		animate(isShowing: false) { _ in
			self.dismiss(animated: false, completion: nil)
		}
	}
	
	func animate(isShowing: Bool, completion: ((Void) -> Void)?){
		
	}
	
	@discardableResult
	static func show(items: [String], handler: @escaping SheeterActionHandler) -> SheeterViewController?{
		let vc = nibViewController
		vc?.items = items
		vc?.handler = handler
		vc?.show()
		return vc
	}
	
	@discardableResult
	static func show(customView: UIView) -> SheeterViewController?{
		let vc = nibViewController
		vc?.customView = customView
		vc?.show()
		return vc
	}
}

extension SheeterViewController: UITableViewDelegate{
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		handler?(indexPath.row)
		dismiss()
	}
}

extension SheeterViewController: UITableViewDataSource{
	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")

		cell.textLabel?.textAlignment = .center
		cell.textLabel?.text = items[indexPath.row]
		cell.textLabel?.font = UIFont.systemFont(ofSize: appearance.fontSize)
		
		return cell
	}
}
