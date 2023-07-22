//
//  PageLabel.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class PageLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	required init(title: String) {
		super.init(frame: .zero)
		configure()
		setTitle(title)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		textAlignment = .center
		font = .systemFont(ofSize: 40, weight: .light)
		textColor = .grayTextColor
	}
	
	func setTitle(_ title: String) {
		text = title
	}
}
