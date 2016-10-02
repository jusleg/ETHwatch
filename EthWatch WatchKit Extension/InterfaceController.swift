//
//  InterfaceController.swift
//  EthWatch WatchKit Extension
//
//  Created by Justin on 2016-09-24.
//  Copyright © 2016 Justin. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class InterfaceController: WKInterfaceController {
    typealias JSONStandard = [String : AnyObject]
    
    //prices
    @IBOutlet var ethPrice: WKInterfaceLabel!
    @IBOutlet var btcPrice: WKInterfaceLabel!
    @IBOutlet var ltcPrice: WKInterfaceLabel!
    @IBOutlet var etcPrice: WKInterfaceLabel!
    
    //percent
    @IBOutlet var ethPercent: WKInterfaceLabel!
    @IBOutlet var btcPercent: WKInterfaceLabel!
    @IBOutlet var ltcPercent: WKInterfaceLabel!
    @IBOutlet var etcPercent: WKInterfaceLabel!
    
    //group
    @IBOutlet var ethGroup: WKInterfaceGroup!
    @IBOutlet var btcGroup: WKInterfaceGroup!
    @IBOutlet var ltcGroup: WKInterfaceGroup!
    @IBOutlet var etcGroup: WKInterfaceGroup!
    @IBOutlet var totalLabel: WKInterfaceLabel!
    @IBAction func refreshMenu() {
        //load()
        print("reload")
    }
    @IBOutlet var percentLabel: WKInterfaceLabel!
    
    var ethCount : Double = 156.49964
    var btcCount : Double = 1
    var etcCount : Double = 0.0029
    var ltcCount : Double = 0
    var ethpriceD : Double = 0.0
    var btcpriceD : Double = 0.0
    var ltcpriceD : Double = 0.0
    var etcpriceD : Double = 0.0
    var total : Double = 0.0
    var percents : Double = 0.0
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        //load()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        load()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func load(){
        Alamofire.request("https://poloniex.com/public?command=returnTicker").responseJSON{ response in
            self.total = 0.0
            self.percents = 0.0
            self.parseData(JSONData: response.data!)
            self.totalLabel.setText("$" + String(format: "%.02f", self.total))
            self.percents = self.percents / self.total
            if self.percents >= 0 {
                self.percentLabel.setText("↑"+String(format: "%.02f", self.percents)+"%")
                self.percentLabel.setTextColor(#colorLiteral(red: 0.3226388779, green: 0.7569414559, blue: 0.3454180179, alpha: 1))
            } else {
                self.percents *= -1
                self.percentLabel.setText("↓"+String(format: "%.02f", self.percents)+"%")
                self.percentLabel.setTextColor(#colorLiteral(red: 0.8759275675, green: 0.2409393787, blue: 0.1935878694, alpha: 1))
            }
        }
    }
    
    func parseData(JSONData: Data) {

        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let ticker = readableJSON["USDT_ETH"] as?  JSONStandard{
                if let price = ticker["last"] {
                    ethpriceD = (price as! NSString).doubleValue
                    print("$"+String(ethpriceD))
                    ethPrice.setText("$"+String(ethpriceD))
                    total += ethpriceD * ethCount
                }
                if let percent = ticker["percentChange"] {
                    var percentD : Double = (percent as! NSString).doubleValue
                    percentD = percentD * 100
                    percents += percentD * ethCount * ethpriceD
                    var returnString : String
                    if percentD >= 0 {
                        returnString = "↑" + String(format: "%.02f", percentD) + "%"
                        ethGroup.setBackgroundColor(#colorLiteral(red: 0.3226388779, green: 0.7569414559, blue: 0.3454180179, alpha: 1))
                    } else {
                        percentD = percentD * -1
                        returnString = "↓" + String(format: "%.02f", percentD) + "%"
                        ethGroup.setBackgroundColor(#colorLiteral(red: 0.8759275675, green: 0.2409393787, blue: 0.1935878694, alpha: 1))
                    }
                    ethPercent.setText(returnString)
                }
            }
            if let ticker = readableJSON["USDT_BTC"] as?  JSONStandard{
                if let price = ticker["last"] {
                    btcpriceD = (price as! NSString).doubleValue
                    print(btcpriceD)
                    btcPrice.setText("$"+String(btcpriceD))
                    total += btcpriceD * btcCount
                }
                if let percent = ticker["percentChange"] {
                    var percentD : Double = (percent as! NSString).doubleValue
                    percentD = percentD * 100
                    percents += percentD * btcCount * btcpriceD
                    var returnString : String
                    if percentD >= 0 {
                        returnString = "↑" + String(format: "%.02f", percentD) + "%"
                        btcGroup.setBackgroundColor(#colorLiteral(red: 0.3226388779, green: 0.7569414559, blue: 0.3454180179, alpha: 1))
                    } else {
                        percentD = percentD * -1
                        returnString = "↓" + String(format: "%.02f", percentD) + "%"
                        btcGroup.setBackgroundColor(#colorLiteral(red: 0.8759275675, green: 0.2409393787, blue: 0.1935878694, alpha: 1))
                    }
                    btcPercent.setText(returnString)
                }
            }
            if let ticker = readableJSON["USDT_ETC"] as?  JSONStandard{
                if let price = ticker["last"] {
                    etcpriceD = (price as! NSString).doubleValue
                    print(etcpriceD)
                    etcPrice.setText("$"+String(etcpriceD))
                    total += etcpriceD * etcCount
                }
                if let percent = ticker["percentChange"] {
                    var percentD : Double = (percent as! NSString).doubleValue
                    percentD = percentD * 100
                    percents += percentD * etcCount * etcpriceD
                    var returnString : String
                    if percentD >= 0 {
                        returnString = "↑" + String(format: "%.02f", percentD) + "%"
                        etcGroup.setBackgroundColor(#colorLiteral(red: 0.3226388779, green: 0.7569414559, blue: 0.3454180179, alpha: 1))
                    } else {
                        percentD = percentD * -1
                        returnString = "↓" + String(format: "%.02f", percentD) + "%"
                        etcGroup.setBackgroundColor(#colorLiteral(red: 0.8759275675, green: 0.2409393787, blue: 0.1935878694, alpha: 1))
                    }
                    etcPercent.setText(returnString)
                }
            }
            if let ticker = readableJSON["USDT_LTC"] as?  JSONStandard{
                if let price = ticker["last"] {
                    ltcpriceD = (price as! NSString).doubleValue
                    print(ltcpriceD)
                    ltcPrice.setText("$"+String(ltcpriceD))
                    total += ltcpriceD * ltcCount
                }
                if let percent = ticker["percentChange"] {
                    var percentD : Double = (percent as! NSString).doubleValue
                    percentD = percentD * 100
                    percents += percentD * ltcCount * ltcpriceD
                    var returnString : String
                    if percentD >= 0 {
                        returnString = "↑" + String(format: "%.02f", percentD) + "%"
                        ltcGroup.setBackgroundColor(#colorLiteral(red: 0.3226388779, green: 0.7569414559, blue: 0.3454180179, alpha: 1))
                    } else {
                        percentD = percentD * -1
                        returnString = "↓" + String(format: "%.02f", percentD) + "%"
                        ltcGroup.setBackgroundColor(#colorLiteral(red: 0.8759275675, green: 0.2409393787, blue: 0.1935878694, alpha: 1))
                    }
                    ltcPercent.setText(returnString)
                }
            }
            
        } catch {
            print(error)
        }
    }

}
