//
//  InsertViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/04.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textClubName: UITextField!
    @IBOutlet var textClubField: UITextField!
    @IBOutlet var textDescription: UITextView!
    @IBOutlet var textApply: UITextView!
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var dateLabel: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // delegate 연결
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        self.dateLabel.text = dateFormatter.string(from: self.pickerDate.date)
    }
    
    @IBAction func saveClub(_ sender: UIBarButtonItem) {
        let name = textTitle.text!
        let clubName = textClubName.text!
        let clubField = textClubField.text!
        let description = textDescription.text!
        let apply = textApply.text!
        let dueDate = dateLabel.text!
        
        if (name == "" || clubName == "") {
            let alert = UIAlertController(title: "제목 혹은 동아리 이름을 \n입력하세요!",
                                          message: "필수 입력 사항입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        if (clubField == "" || description == "") {
            let alert = UIAlertController(title: "동아리 분야 혹은 소개 내용을 \n입력하세요!",
                                          message: "필수 입력 사항입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        if (apply == "" || dueDate == "날짜를 설정하고 입력을 누르세요") {
            let alert = UIAlertController(title: "지원 방법 혹은 마감 날짜를 \n입력하세요!",
                                          message: "필수 입력 사항입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        
        let urlString: String = "http://condi.swu.ac.kr/student/M13/project/insertFavorite.php"
        guard let requestURL = URL(string: urlString) else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        
        var restString: String = "id=" + userID + "&name=" + name
        restString += "&clubName=" + clubName + "&clubField=" + clubField
        restString += "&description=" + description
        restString += "&apply=" + apply + "&dueDate=" + dueDate
        request.httpBody = restString.data(using: .utf8)
        
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data)}
        }
        task2.resume()
        _ = self.navigationController?.popViewController(animated: true)
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
