//
//  InterfaceController.swift
//  WatchConnectivity Introduction WatchKit Extension
//
//  Created by Davis Allie on 25/08/2015.
//  Copyright © 2015 tutsplus. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    let dateFormatter = NSDateFormatter()
    var items: [[String: AnyObject?]] = [[:]]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        dateFormatter.dateFormat = "EEEE"
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.items.removeAll()
        
        if let newItems = NSUserDefaults.standardUserDefaults().objectForKey("items") as? [[String: AnyObject?]] {
            self.items = newItems
            self.table.setNumberOfRows(self.items.count, withRowType: "BasicRow")
            
            for i in 0..<self.items.count {
                if let row = self.table.rowControllerAtIndex(items.count-1) as? TableRow {
                    let date = self.items[i]["date"] as! NSDate
                    row.mainTitle.setText("\(date)")
                    row.subtitle.setText(self.items[i]["day"] as? String)
                }
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func addItem() {
        let date = NSDate()
        
        let item = ["date": date, "day": dateFormatter.stringFromDate(date)]
        self.items.append(item)
        print(self.items)
        
        if self.items.count == 1 {
            self.table.setNumberOfRows(1, withRowType: "BasicRow")
        } else {
            self.table.insertRowsAtIndexes(NSIndexSet(index: items.count-1), withRowType: "BasicRow")
        }
        
        if let row = self.table.rowControllerAtIndex(items.count-1) as? TableRow {
            row.mainTitle.setText("\(date)")
            row.subtitle.setText(item["day"] as? String)
        }
    }
}
