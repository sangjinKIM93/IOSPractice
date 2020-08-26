//
//  ReactorViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/08/26.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit

class CounterViewController: UIViewController, StoryboardView {

    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    func bind(reactor: CounterViewReactor) {
        // Action 바인딩
        plusBtn.rx.tap
            .map{ Reactor.Action.increase }     //increase 액션이
            .bind(to: reactor.action)           //reactor에 전달된다.
            .disposed(by: disposeBag)
        
        minusBtn.rx.tap
            .map{ Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State 바인딩
        reactor.state
            .map{ $0.value }
            .distinctUntilChanged()     //이전값이랑 다를때만
            .map{ "\($0)" }
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
        
}
