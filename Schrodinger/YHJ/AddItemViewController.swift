//
//  YHJViewController.swift
//  Schrodinger
//
//  Created by ido on 2021/07/29.
//

import UIKit

class AddItemViewController: UIViewController {

    var itemName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Write 버튼을 눌렀을 때
    @IBAction func btnWrite(_ sender: UIButton) {
        
        // Alert 선언
        let alert = UIAlertController(title: "Item name", message: "please add item name, It is shown in your item list", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler:
                                {ACTION in
                                    self.itemName = alert.textFields![0].text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                                    self.performSegue(withIdentifier: "sgWrite", sender: self)
                                })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextField{ (textField) -> Void in
            textField.placeholder = "Placeholder"
        }
        present(alert, animated: true, completion: nil)
    }// btnWrite
    
    // Segue 선언
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Write segue
        if segue.identifier == "sgWrite"{

            let addItemDetailViewController = segue.destination as! AddItemDetailViewController
            
            addItemDetailViewController.itemName = itemName
            present(addItemDetailViewController, animated: true, completion: nil)
        }
        
        // Barcode segue
        if segue.identifier == "sgBarcode"{

            let readerViewController = segue.destination as! ReaderViewController
        
            present(readerViewController, animated: true, completion: nil)
        }
    }
    
} // AddItemViewController
