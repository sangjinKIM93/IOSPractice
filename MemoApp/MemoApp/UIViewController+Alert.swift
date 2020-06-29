//
//  UIViewController+Alert.swift
//  MemoApp
//
//  Created by 김상진 on 2020/06/29.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String = "알림", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        //세번째 파라미터는 버튼을 클릭했을대 전달할 코드
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
