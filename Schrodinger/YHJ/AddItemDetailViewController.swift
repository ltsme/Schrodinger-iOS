//
//  AddItemDetailViewController.swift
//  Schrodinger
//
//  Created by HyeonJoonYang on 2021/07/30.
//

import UIKit

class AddItemDetailViewController: UIViewController {
    
    var itemName : String = ""
    var itemCategory : String = ""
    var itemExpirationDate : String = ""
    var itemMemo : String = ""
    var itemImage : String = "image"
    
    @IBOutlet var ivImg: UIImageView!
    @IBOutlet var lblItemName: UILabel!
    @IBOutlet var btnCategory1: UIButton!
    @IBOutlet var btnCategory2: UIButton!
    @IBOutlet var btnCategory3: UIButton!
    @IBOutlet var tfMemo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰 초기화
        //ivImg.isHidden = true
        ivImg.image = UIImage(named: "banana.jpeg")
        ivImg.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        
        // 텍스트 뷰 초기화
        lblItemName.text = itemName
        
        // 카테고리 버튼 초기화
        btnSelected(btnNum: 1)
        
    }
    @IBAction func btnCategory1(_ sender: UIButton) {
        btnSelected(btnNum: 0)
    }
    @IBAction func btnCategory2(_ sender: UIButton) {
        btnSelected(btnNum: 1)
    }
    @IBAction func btnCategory3(_ sender: UIButton) {
        btnSelected(btnNum: 2)
    }
    
    func btnSelected(btnNum : Int) {
        btnInitial()
        
        switch btnNum {
        case 1:
            btnCategory1.setTitleColor(UIColor.systemRed, for: .normal)
            itemCategory = "0"
            break
        case 2:
            btnCategory2.setTitleColor(UIColor.systemRed, for: .normal)
            itemCategory = "1"
            break
        case 3:
            btnCategory3.setTitleColor(UIColor.systemRed, for: .normal)
            itemCategory = "2"
            break
        default:
            break
        }
    }
    
    func btnInitial(){
        btnCategory1.setTitleColor(UIColor.systemGreen, for: .normal)
        btnCategory2.setTitleColor(UIColor.systemGreen, for: .normal)
        btnCategory3.setTitleColor(UIColor.systemGreen, for: .normal)
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let chooseDate = sender.date
        let formatter = DateFormatter()
                
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd"
                
        itemExpirationDate = "\(formatter.string(from: chooseDate as Date))"
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        itemMemo = tfMemo.text
        
        // QueryModel 처럼 InsertModel을 만들어야 함 : swift.file
        let insertModel = InsertModel()
        let result = insertModel.insertItems(name: itemName, category: itemCategory, expirationdate: itemExpirationDate, memo: itemMemo, image: itemImage)
        
        if result{
            let resultAlert = UIAlertController(title: "완료", message: "입력되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
       
        }else{
            let resultAlert = UIAlertController(title: "에러", message: "에러가 발생했습니다..", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
            
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
