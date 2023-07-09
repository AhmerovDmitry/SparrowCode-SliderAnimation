//
//  ViewController.swift
//  3 - slider animation
//
//  Created by Ахмеров Дмитрий Николаевич on 09.07.2023.
//

import UIKit

final class ViewController: UIViewController {

	private lazy var squareView: UIView = {
		let view = UIView(frame: .init(x: view.layoutMargins.left, y: view.layoutMargins.top, width: 50, height: 50))
		view.backgroundColor = .systemBlue
		view.layer.cornerRadius = 10
		return view
	}()

	private lazy var slider: UISlider = {
		let slider = UISlider(frame: .init(x: view.layoutMargins.left,
										   y: view.layoutMargins.top + view.layoutMargins.bottom,
										   width: view.frame.width - (view.layoutMargins.left + view.layoutMargins.right),
										   height: 50))
		slider.addTarget(self, action: #selector(userDidDragSlider), for: .valueChanged)
		slider.addTarget(self, action: #selector(userDidTouchUpSlider), for: .touchUpInside)
		return slider
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.layoutMargins = .init(top: 100, left: 10, bottom: 100, right: 10)
		view.backgroundColor = .systemBackground
		setupUIHierarchy()
	}
}

// MARK: - Private

private extension ViewController {

	func setupUIHierarchy() {
		view.addSubview(squareView)
		view.addSubview(slider)
	}

	func animationSquare(_ sender: UISlider) {
		let rotationValue = CGFloat(slider.value) * (.pi / 2)
		let scaleValue = CGFloat(slider.value) * 0.5 + 1
		squareView.transform = CGAffineTransform(rotationAngle: rotationValue).scaledBy(x: scaleValue, y: scaleValue)
	}

	func moveSquare(_ sender: UISlider) {
		let minValue = view.layoutMargins.left + squareView.frame.width / 2
		let maxValue = view.frame.width - view.layoutMargins.right - squareView.frame.width / 2
		squareView.center.x = minValue + (maxValue - minValue) * CGFloat(sender.value)
	}

	@objc func userDidDragSlider(_ sender: UISlider) {
		animationSquare(sender)
		moveSquare(sender)
	}

	@objc func userDidTouchUpSlider(_ sender: UISlider) {
		sender.setValue(sender.maximumValue, animated: true)
		UIView.animate(withDuration: 0.5) {
			self.userDidDragSlider(sender)
		}
	}
}
