//
//  ClubDetailViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData //추가!

class ClubDetailViewController: UIViewController {
    @IBOutlet var textName: UILabel!
    @IBOutlet var textClubName: UILabel!
    @IBOutlet var textClubField: UILabel!
    @IBOutlet var textDescription: UILabel!
    @IBOutlet var textDueDate: UILabel!
    @IBOutlet var textApply: UILabel!
    
    // 상위 View에서 자료를 넘겨 받기 위한 변수
    var selectedData: ClubData?
    
    func getContext () -> NSManagedObjectContext { // 추가!!
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let clubData = selectedData else { return }
        textName.text = clubData.name
        textClubName.text = clubData.clubName
        textClubField.text = clubData.clubField
        textDescription.numberOfLines = 0
        textDescription.text = clubData.descript
        textDueDate.text = clubData.dueDate
        textApply.text = clubData.apply
    }
    
    @IBAction func goInterest() {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Clubs", in: context)
        
        // record를 새로 생성함
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(appDelegate.ID, forKey: "c_id")
        object.setValue(textName.text, forKey: "c_name")
        object.setValue(textClubName.text, forKey: "c_clubName")
        object.setValue(textClubField.text, forKey: "c_clubField")
        object.setValue(textDescription.text, forKey: "c_description")
        object.setValue(textDueDate.text, forKey: "c_dueDate")
        object.setValue(textApply.text, forKey: "c_apply")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)") }
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
