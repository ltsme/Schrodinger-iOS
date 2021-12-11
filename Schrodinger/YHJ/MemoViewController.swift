////
////  MemoViewController.swift
////  Schrodinger
////
////  Created by HyeonJoonYang on 2021/08/13.
////
//
//import UIKit
//
//class MemoViewController: UIViewController {
//
//    @IBOutlet weak var btn_back_memo: UINavigationItem!
//    @IBOutlet weak var D_tv_Memomain: UITextView!
//
//
//    var preparememo = ""
//    var delegate: MemoEdit?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        D_tv_Memomain.text = "\(preparememo)"
//
//    }
//
//    @IBAction func M_btn_memoUpdate(_ sender: UIBarButtonItem) {
//
//
//        if delegate != nil{
//            delegate?.didMessageEditDone(self, message: D_tv_Memomain.text) // viewcontroller의 함수를         }
//            navigationController?.popViewController(animated: true) // 화면 보내는 친구
//        }
//
//
//    }
//}
//
//
