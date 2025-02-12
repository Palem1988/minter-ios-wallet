//
//  String+RawTransactionAddress.swift
//  MinterWallet
//
//  Created by Alexey Sidorov on 29/05/2018.
//  Copyright © 2018 Minter. All rights reserved.
//

import Foundation

extension String {
	
	func isValidAddress() -> Bool {
		let addressTest = NSPredicate(format:"SELF MATCHES %@", "^Mx[a-zA-Z0-9]{40}$")
		return addressTest.evaluate(with: self)
	}
	
	func isValidPublicKey() -> Bool {
		let publicKeyTest = NSPredicate(format:"SELF MATCHES %@", "^Mp[a-fA-F0-9]{64}$")
		return publicKeyTest.evaluate(with: self)
	}

}
