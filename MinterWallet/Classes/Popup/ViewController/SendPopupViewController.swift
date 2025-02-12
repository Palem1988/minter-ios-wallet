//
//  SendPopupViewController.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 18/04/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import AlamofireImage

protocol SendPopupViewControllerDelegate: class {
	func didFinish(viewController: SendPopupViewController)
	func didCancel(viewController: SendPopupViewController)
}

class SendPopupViewController: PopupViewController {

	// MARK: -

	weak var delegate: SendPopupViewControllerDelegate?

	// MARK: - IBOutlet

	@IBOutlet weak var avatarWrapper: UIView! {
		didSet {
			avatarWrapper.layer.cornerRadius = 25.0
			avatarWrapper?.layer.applySketchShadow(color: UIColor(hex: 0x000000, alpha: 0.2)!, alpha: 1, x: 0, y: 2, blur: 18, spread: 0)
		}
	}

	@IBOutlet weak var amountTitle: UILabel!

	@IBOutlet weak var avatarImage: UIImageView! {
		didSet {
			avatarImage.backgroundColor = .white
			avatarImage.makeBorderWithCornerRadius(radius: 25, borderColor: .clear, borderWidth: 4)		
		}
	}

	@IBOutlet weak var userLabel: UILabel!

	@IBOutlet weak var actionButton: DefaultButton!

	@IBOutlet weak var cancelButton: DefaultButton!

	@IBOutlet weak var acitionButtonActivityIndicator: UIActivityIndicatorView!

	@IBAction func secondButtonDidTap(_ sender: UIButton) {
		self.delegate?.didCancel(viewController: self)
	}

	@IBAction func didTapActionButton(_ sender: UIButton) {
		acitionButtonActivityIndicator?.startAnimating()
		acitionButtonActivityIndicator?.alpha = 1.0
		sender.isEnabled = false

		self.delegate?.didFinish(viewController: self)
	}

	// MARK: -

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		hidesBottomBarWhenPushed = true
	}

	// MARK: -

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		AnalyticsHelper.defaultAnalytics.track(event: .SendCoinPopupScreen, params: nil)
	}

	override func loadView() {
		super.loadView()
		updateUI()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: -

	private func updateUI() {

		let sendViewModel = viewModel as? SendPopupViewModel

		popupTitle.text = sendViewModel?.popupTitle

		amountTitle.text = String((sendViewModel?.amountString ?? "") + " " + (sendViewModel?.coin ?? "")).uppercased()
		avatarImage.image = UIImage(named: "AvatarPlaceholderImage")
		if let img = sendViewModel?.avatarImage {
			avatarImage.image = img
		} else if let avatarURL = sendViewModel?.avatarImageURL {
			avatarImage.af_setImage(withURL: avatarURL, filter: RoundedCornersFilter(radius: 25.0))
		}
		userLabel.text = sendViewModel?.username
		actionButton.setTitle(sendViewModel?.buttonTitle ?? "", for: .normal)
		cancelButton.setTitle(sendViewModel?.cancelTitle ?? "", for: .normal)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}

}
