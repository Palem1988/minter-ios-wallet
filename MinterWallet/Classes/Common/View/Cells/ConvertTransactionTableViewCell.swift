//
//  ConvertTransactionTableViewCell.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 11/07/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import UIKit
import AlamofireImage

class ConvertTransactionTableViewCellItem: BaseCellItem {
	var txHash: String?
	var title: String?
	var image: UIImage?
	var date: Date?
	var from: String?
	var to: String?
	var fromCoin: String?
	var toCoin: String?
	var fromAmount: Decimal?
	var toAmount: Decimal?
	var expandable: Bool?
}

protocol ConvertTransactionTableViewCellDelegate: class {
	func didTapExpandedButton(cell: ConvertTransactionTableViewCell)
}

class ConvertTransactionTableViewCell: ExpandableCell {

	// MARK: -

	let formatter = CurrencyNumberFormatter.transactionFormatter
	let decimalFormatter = CurrencyNumberFormatter.decimalFormatter
	let dateFormatter = TransactionDateFormatter.transactionDateFormatter
	let timeFormatter = TransactionDateFormatter.transactionTimeFormatter

	weak var delegate: ConvertTransactionTableViewCellDelegate?

	// MARK: - IBOutlet

	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var coinImageWrapper: UIView! {
		didSet {
			coinImageWrapper.layer.applySketchShadow(color: UIColor(hex: 0x000000, alpha: 0.2)!, alpha: 1, x: 0, y: 2, blur: 18, spread: 0)
		}
	}

	@IBOutlet weak var coinImage: UIImageView! {
		didSet {
			coinImage.layer.cornerRadius = 17.0
			coinImage.makeBorderWithCornerRadius(radius: 17.0,
																					 borderColor: .clear,
																					 borderWidth: 2.0)
		}
	}

	@IBOutlet weak var amount: UILabel!
	@IBOutlet weak var coin: UILabel!
	@IBOutlet weak var expandedAmountLabel: UILabel!
	@IBOutlet weak var expandedReceivedAmountLabel: UILabel!
	@IBOutlet weak var expandedToCoinLabel: UILabel!
	@IBOutlet weak var coinLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!

	// MARK: -

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	// MARK: -

	override func configure(item: BaseCellItem) {
		if let transaction = item as? ConvertTransactionTableViewCellItem {
			identifier = item.identifier
			title.text = transaction.title
			coinImage.image = UIImage(named: "convertImage")
			if let image = transaction.image {
				coinImage.image = image
			}
			if nil == transaction.toAmount {
				amount.text = ""
			} else {
				amount.text = amountText(amount: transaction.toAmount ?? 0)
			}
			amount.textColor = ((transaction.toAmount ?? 0) > 0) ? UIColor(hex: 0x35B65C) : .black

			expandedAmountLabel.text = CurrencyNumberFormatter.formattedDecimal(with: (transaction.fromAmount ?? 0),
																																					formatter: CurrencyNumberFormatter.coinFormatter)
			expandedReceivedAmountLabel.text = CurrencyNumberFormatter
				.formattedDecimal(with: (transaction.toAmount ?? 0),
																																									formatter: CurrencyNumberFormatter.coinFormatter)

			coinLabel.text = transaction.fromCoin
			expandedToCoinLabel.text = transaction.toCoin
			dateLabel.text = dateFormatter.string(from: transaction.date ?? Date())
			timeLabel.text = timeFormatter.string(from: transaction.date ?? Date())

			coin.text = transaction.toCoin
			expandable = transaction.expandable ?? false
		}
	}

	private func amountText(amount: Decimal) -> String {
		return CurrencyNumberFormatter.formattedDecimal(with: amount,
																										formatter: 	CurrencyNumberFormatter.transactionFormatter)
	}

	// MARK: -

	@IBAction func didTapExpandedButton(_ sender: Any) {
		delegate?.didTapExpandedButton(cell: self)
	}
}
