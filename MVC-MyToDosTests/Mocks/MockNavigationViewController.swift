//
//  MockNavigationViewController.swift
//  MVC-MyToDosTests
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class MockNavigationViewController: UINavigationController {
	var vcIsPushed: Bool = false
	var vcIsPoped: Bool = false
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: animated)
		vcIsPushed = true
	}
	override func popViewController(animated: Bool) -> UIViewController? {
		vcIsPoped = true
		return viewControllers.first
	}
}
