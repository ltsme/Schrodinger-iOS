//
//  AddItemDetailViewController.swift
//  Schrodinger
//
//  Created by HyeonJoonYang on 2021/07/30.
//

import UIKit

class AddItemDetailViewController: UIViewController {
    
    var itemName : String = ""
    var itemExpirationDate : String = ""
    var itemCategory : String = ""
    var itemMemo : String = ""
    var itemImage : String = ""
    
    @IBOutlet var ivImg: UIImageView!
    @IBOutlet var lblItemName: UILabel!
    @IBOutlet var lblItemExpireDate: UILabel!
    @IBOutlet var btnCategory1: UIButton!
    @IBOutlet var btnCategory2: UIButton!
    @IBOutlet var btnCategory3: UIButton!
    @IBOutlet var tfMemo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                if itemName == "빙그레 바나나맛 우유" {
                    // 이미지 뷰 초기화
                    //ivImg.isHidden = true
                    //ivImg.image = UIImage(named: "banana.jpeg")
                }else {
        //ivImg.image = UIImage(named: "banana2.jpeg")
                }
        
        
        
        
        // 텍스트 뷰 초기화
        lblItemName.text = itemName
        lblItemExpireDate.text = "권장 유통기한 : \(itemExpirationDate)"
        
        // 카테고리 값 초기화
        btnSelected(btnNum: 0)
        
        // 메모 클릭시 이벤트
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        //        tfMemo.addGestureRecognizer(tapGestureRecognizer)
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
        case 0:
            btnCategory1.setTitleColor(UIColor.systemRed, for: .normal)
            itemCategory = "0"
            break
        case 1:
            btnCategory2.setTitleColor(UIColor.systemRed, for: .normal)
            itemCategory = "1"
            break
        case 2:
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
        
        // 유통기한 nil값 체크
        if (itemExpirationDate.count != 0) {
            
            let resultAlert = UIAlertController(title: "등록", message: "이대로 등록할까요? :)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .destructive, handler: {ACTION in
                self.insertDB()
            })
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            resultAlert.addAction(ok)
            resultAlert.addAction(cancel)
            present(resultAlert, animated: true, completion: nil)
            
            // 유통기한 값이 nil 일 때
        } else{
            let resultAlert = UIAlertController(title: "경고", message: "유통기한을 지정해 주세요! :(", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "확인", style: .destructive, handler: nil)
            
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: 메모 클릭시 이벤트
    //    @objc func viewMapTapped(sender: UITapGestureRecognizer) {
    //
    //        let memoViewController =  MemoViewController() //인스턴스를 만들어 값을 넘긴다
    //        memoViewController.preparememo = memo
    //        memoViewController.delegate = self // 함수 실행하고 뒤로 화면을 넘긴다
    //
    //        self.performSegue(withIdentifier: "sgMemo", sender: self)
    //
    //    }
    
    func insertDB() {
        itemMemo = tfMemo.text
        
        // QueryModel 처럼 InsertModel을 만들어야 함 : swift.file
        let insertModel = InsertModel()
        let result = insertModel.insertItems(name: itemName, category: itemCategory, expirationdate: itemExpirationDate, memo: itemMemo, image: itemImage)
        
        if result{
            let resultAlert = UIAlertController(title: "완료", message: "입력 되었습니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                self.dismiss(animated: true)
            })
            
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
            
        }else{
            let resultAlert = UIAlertController(title: "에러", message: "에러가 발생했습니다..", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "확인", style: .cancel, handler: { ACTION in
                self.dismiss(animated: true)
            })
            
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
}

// 화면 밖 터치 시, 키보드 숨기기
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
