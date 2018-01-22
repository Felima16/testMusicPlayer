//
//  IAPHandler.swift
//  MusicPlayer_Publicista
//
//  Created by Fernanda de Lima on 21/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit
import StoreKit


class IAPHandler: NSObject {
    static let shared = IAPHandler()
    
    let CONSUMABLE_PURCHASE_PRODUCT_ID = "testpurchase"
    
    
    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
}

