//
//  String+Subscript.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 23/05/2019.
//  Copyright © 2019 Minter. All rights reserved.
//

import Foundation

extension StringProtocol {
	subscript(offset: Int) -> Element {
		return self[index(startIndex, offsetBy: offset)]
	}
	subscript(_ range: Range<Int>) -> SubSequence {
		return prefix(range.lowerBound + range.count)
			.suffix(range.count)
	}
	subscript(range: ClosedRange<Int>) -> SubSequence {
		return prefix(range.lowerBound + range.count)
			.suffix(range.count)
	}
	subscript(range: PartialRangeThrough<Int>) -> SubSequence {
		return prefix(range.upperBound.advanced(by: 1))
	}
	subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
		return prefix(range.upperBound)
	}
	subscript(range: PartialRangeFrom<Int>) -> SubSequence {
		return suffix(Swift.max(0, count - range.lowerBound))
	}
}

extension LosslessStringConvertible {
	var string: String { return .init(self) }
}

extension BidirectionalCollection {
	subscript(safe offset: Int) -> Element? {
		guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
		return self[i]
	}
}
