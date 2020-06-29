//
//  ComposdViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/06/29.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func saveBtn(_ sender: Any) {
        guard let memo = memoTextView.text,
            memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
        }
        
//        let newMemo = Memo(content: memo)
//        Memo.dummyMemoList.append(newMemo)
        DataManager.shared.addNewMemo(memo)
        
        //라디오 방송국. 앱 전체에 broadcast하는거야
        //옵저버가 설치된 곳에서 해당 신호를 받을 수 있어
        NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)    //modal 방식에서의 취소
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ComposeViewController {
    //notificataion : 라디오 방송
    static let newMemoDidInsert = Notification.Name("newMemoInsert")
}
