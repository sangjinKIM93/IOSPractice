//
//  TransitionViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/08/27.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        practiceAnimation()
    }

    @IBAction func nextToButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Transition", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        
    }
    
    //애니메이션 연습
    func practiceAnimation() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let myView = UIView(frame: rect)
        myView.backgroundColor = .gray
        view.addSubview(myView)
        
        //기본 사용 - 시간 & 변경될 사항
        UIView.animate(withDuration: 0.5) {
            myView.backgroundColor = .white
        }

        //두개의 애니메이션 순차 사용
        UIView.animate(withDuration: 2.0, animations: {
            myView.backgroundColor = .white
        }) { (_) in
            UIView.animate(withDuration: 2.0, animations: {
                myView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
            })
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [.curveEaseIn, .repeat, .autoreverse], animations: {
           myView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        })
    }


}
