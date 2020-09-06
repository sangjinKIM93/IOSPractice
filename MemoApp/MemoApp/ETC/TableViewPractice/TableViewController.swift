//
//  TableViewController.swift
//  MemoApp
//
//  Created by 김상진 on 2020/09/05.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        
    }
    
}

extension TableViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as! FirstTableViewCell
        let secondCell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
        
        firstCell.swtich.addTarget(self, action: #selector(switchTouched), for: .touchUpInside)
        secondCell.switch2.addTarget(self, action: #selector(switchTouched), for: .touchUpInside)
        
        if indexPath.row == 0 {
            return firstCell
        } else {
            return secondCell
        }
        
    }
    
    //음... 근데 customCell 하나로 가야해...
    //그렇지 않으면 일일이 다 함수를 구현해줘야해.
    //아니면 이름을 같게 해주면 다 동작하나?
    //**아니면 addtarget을 같은 함수로 해주면 됨.
    
    @objc func switchTouched() {
        print("스위치가 눌렸습니다.")
    }
    
}
