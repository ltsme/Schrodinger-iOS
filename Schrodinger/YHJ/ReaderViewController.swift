//
//  ReaderViewController.swift
//  Schrodinger
//
//  Created by HyeonJoonYang on 2021/07/30.
//

import UIKit
import AVFoundation
import SwiftSoup

class ReaderViewController: UIViewController {
    
    // 각종 변수 선언
    var strItemName : String = ""
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
 
    // webCrawling (SwiftSoup)
    func doCrawling(code : String) {
        
        let Barcode = code
        let idKey : String = "f35b8b370050494daeae" // API KEY
        var startNum : Int = 1 // 검색 시작 번호
        var endNum : Int = 1000 // 검색 끝 번호 (우선 1만개 까지 검색할 예정)
        let increase : Int = 1000
        
        while endNum < 5000 {
        
            var urlAddress = URL(string: "https://openapi.foodsafetykorea.go.kr/api/\(idKey)/C005/xml/\(startNum)/\(endNum)/BAR_CD=\(Barcode)")

            guard let myUrl = urlAddress else { return }
            
            do {
                let myUrlStr = try String(contentsOf: myUrl, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(myUrlStr)
                
                // 텍스트 크롤링 클래스.end_model 안 h3 태그 정보를 result에 저장
                let result : Elements = try doc.select("row").select("PRDLST_NM")
                
//                // 이미지 크롤링
//                let imagesrc: Elements = try doc.select("div#carMainImgArea.img_group").select("div.main_img").select("img[src]")
//                let stringImage = try imagesrc.attr("src").description
//                let urlImage = URL(string: stringImage)
//                let data = try Data(contentsOf: urlImage!)
//                ivTest.image = UIImage(data: data)
                
                // 찾았을 경우 종료
                if try result.text().isEmpty{
                    startNum += increase
                    endNum += increase
                }else{
                    endNum = 5000
                    strItemName = try result.text()
                }
                
            } catch Exception.Error(let type, let message) {
                print("Message : \(message)")
            } catch {
                print("error")
            }
        }// while
        
        if strItemName.isEmpty{
            strItemName = "결과 없음"
        }
        
    }// doCrawling
    
}//ReaderViewController


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
            
            // 0810 크롤링 기능
            doCrawling(code: code)
        
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
                addItemDetailViewController.itemName = self.strItemName
                
                self.dismiss(animated: true) {
                    pvc.present(addItemDetailViewController, animated: true, completion: nil)
                }
            }
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
