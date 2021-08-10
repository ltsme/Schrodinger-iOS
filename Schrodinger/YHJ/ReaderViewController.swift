//
//  ReaderViewController.swift
//  Schrodinger
//
//  Created by HyeonJoonYang on 2021/07/30.
//

import UIKit
import AVFoundation

class ReaderViewController: UIViewController {
    
    var strName : String = ""

    @IBOutlet weak var readerView: ReaderView!
//    @IBOutlet weak var readButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.readerView.delegate = self
        
        // 0809 수정, 버튼 기능 삭제 및 바로 바코드 기능 동작
        self.readerView.start()
    }

    // 뷰가 꺼지는 도중 readerView 기능 종료
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
}

extension ReaderViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {

        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            // read성공
            title = ""
            message = "인식 성공!\n 등록 화면으로 넘어갑니다."
            
            // 0809 수정 , 받은 바코드 값을 전역변수 strName에 넣어줌
            strName = code
        
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
            } else {
                return
            }
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            
            // 0809 수정 : 확인 클릭 시 값을 넘겨 주며 화면 이동
            if let addItemDetailViewController =  self.storyboard?.instantiateViewController(identifier: "idAddItemDetailViewController") as? AddItemDetailViewController
            {
                guard let pvc = self.presentingViewController else {return}
                addItemDetailViewController.itemName = self.strName
                self.dismiss(animated: true) {
                    pvc.present(addItemDetailViewController, animated: true, completion: nil)
                }
            }
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
