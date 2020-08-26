//
//  CounterViewReactor.swift
//  MemoApp
//
//  Created by 김상진 on 2020/08/26.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import ReactorKit

class CounterViewReactor: Reactor {
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
    }
    
    struct State {
        var value: Int = 0
    }
    
    let initialState = State()
    
    func mutate(action: CounterViewReactor.Action) -> Observable<CounterViewReactor.Mutation> {
        switch action {
        case .increase:
            return Observable.just(Mutation.increaseValue)
        case .decrease:
            return Observable.just(Mutation.decreaseValue)
        }
    }
    
    func reduce(state: CounterViewReactor.State, mutation: CounterViewReactor.Mutation) -> CounterViewReactor.State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        }
        return newState
    }
}
