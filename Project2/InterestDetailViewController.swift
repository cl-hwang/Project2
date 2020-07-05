//
//  InterestDetailViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class InterestDetailViewController: UIViewController {
    
    @IBOutlet var cTextClubName: UILabel!
    @IBOutlet var cTextClubField: UILabel!
    @IBOutlet var cDescription: UILabel!
    @IBOutlet var cDueDate: UILabel!
    @IBOutlet var cApply: UILabel!
    
    var detailInterest: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let interest = detailInterest {
            cTextClubName.text = interest.value(forKey: "c_clubName") as? String
            cTextClubField.text = interest.value(forKey: "c_clubField") as? String
            cDescription.text = interest.value(forKey: "c_description") as? String
            cDueDate.text = interest.value(forKey: "c_dueDate") as? String
            cApply.text = interest.value(forKey: "c_apply") as? String
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
