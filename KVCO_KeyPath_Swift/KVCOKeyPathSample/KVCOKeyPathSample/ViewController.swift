//
//  ViewController.swift
//  KVCOKeyPathSample
//
//  Created by JW_Macbook on 2019/12/11.
//  Copyright © 2019 JW_Macbook. All rights reserved.
//

import UIKit

// Swift KVC, KVO, KeyPath 테스트 하기
@objcMembers class KVCObject: NSObject { // KVO 시 NSObject 상속 필요함. (KVC 에는 상관없음)
    dynamic var name = "" // dynamic 을 사용해야 실시간 변화 감지가 가능함.
    dynamic var age = 0
}

class ViewController: UIViewController {

    let kvcObject1 = KVCObject()
    // 옵져빙 관리할 Array 객체 (deInit 할때 비워주는 로직있으면 됨.)
    private var observerList: [NSKeyValueObservation] = []

    // 옵져빙 할 객체들.
    var kvcObject1Name:NSKeyValueObservation? = nil
    var kvcObject1Age:NSKeyValueObservation? = nil
    
    // 옵져빙 할때 표현하려고
    @IBOutlet weak var lbResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // deInit 때 가지고있는 Ovserver 제거
        observerList.removeAll()
    }
    
    func setObserver() {
        // 옵져버 셋팅 (keyPath에 맞춰서 자료형은 맞춰짐)
        kvcObject1Name = kvcObject1.observe(\.name, options: [.old, .new], changeHandler: { (object, change) in
            print("Name old Value(String)\(change.oldValue) new Value(String)\(change.newValue)")
            
            self.lbResult.text = "\(change.newValue ?? "") \(object.age)"
        })
        // 관리 array 추가
        observerList.append(kvcObject1Name!)
        
        kvcObject1Age = kvcObject1.observe(\.age, options: [.old, .new], changeHandler: { (object, change) in
            print("Age old Value(Int)\(change.oldValue) new Value(Int)\(change.newValue)")
            self.lbResult.text = "\(object.name) \(change.newValue ?? 0)"
        })
        // 관리 array 추가
        observerList.append(kvcObject1Age!)
    }
    
    /// 텍스트뷰 체인지 될때마다. (귀찮아서 델리게이트 안씀.
    /// - Parameter sender:
    @IBAction func textFieldChanged(_ sender: Any) {
        let textField:UITextField = sender as! UITextField
        kvcObject1[keyPath: \.name] = textField.text!
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        let stepper:UIStepper = sender as! UIStepper
        kvcObject1[keyPath: \.age] = Int(stepper.value)
    }
}


