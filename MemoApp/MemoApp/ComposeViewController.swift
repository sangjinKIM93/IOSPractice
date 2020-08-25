//
//  ComposdViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/06/29.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var editTarget: Memo?
    var originalMemoContent: String?
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func saveBtn(_ sender: Any) {
        guard let memo = memoTextView.text,
            memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            return
        }
        
        if let target = editTarget {
            //memo idx를 자체적으로 인식해서 바꿔주나보네?
            target.content = memo
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.memoDidChange, object: nil)
            
        } else {
            DataManager.shared.addNewMemo(memo)
            NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)    //modal 방식에서의 취소
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let memo = editTarget{
            navigationItem.title = "메모 편집"
            memoTextView.text = memo.content
            originalMemoContent = memo.content
        } else {
            navigationItem.title = "새 메모"
            memoTextView.text = ""
        }
        
        memoTextView.delegate = self    //뷰 컨트롤러를 textview의 delegate로 지정
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.presentationController?.delegate = nil
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

//textView의 변화를 감지할 수 있는 코드
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let original = originalMemoContent, let edited = textView.text {
            if #available(iOS 13.0, *) {
                isModalInPresentation = original != edited
            } else {
                
            }
        }
        
    }
}

// 편집중이라 내려가지 않는 상황일때 호출. 즉, isModalInpresentation일때
extension ComposeViewController : UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self](action) in
            self?.saveBtn(action)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default) { [weak self](action) in
            self?.closeBtn(action)
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}


extension ComposeViewController {
    //notificataion : 라디오 방송
    static let newMemoDidInsert = Notification.Name("newMemoInsert")
    static let memoDidChange = Notification.Name("memoDidChange")
}
