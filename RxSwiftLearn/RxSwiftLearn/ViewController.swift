//
//  ViewController.swift
//  RxSwiftLearn
//
//  Created by iqusong on 2018/5/18.
//  Copyright © 2018年 test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var testField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        button.rx.tap.subscribe(onNext: {
               print("hello world")
        }).disposed(by: disposeBag)
      
        URLSession.shared.rx.data(request: URLRequest(url:NSURL.fileURL(withPath: "http://www.baidu.com")))
            .subscribe(onNext: { data in
                print("Data Task Success with count: \(data.count)")
            }, onError: { error in
                print("Data Task Error: \(error)")
            })
            .disposed(by: disposeBag)
        NotificationCenter.default.rx
            .notification(.UIApplicationWillEnterForeground)
            .subscribe(onNext: { (notification) in
                print("Application Will Enter Foreground")
            })
            .disposed(by: disposeBag)
        
       var user = User();
        
//        user.rx.observe(String.self, #keyPath(user.name)).subscribe(onNext:{ newValue in
//            print("do something with:\(String(describing: newValue))")
//        }).disposed(by: disposeBag)
        // 用户名是否有效
        let usernameValid = testField1.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= 5 }
            .share(replay: 1)
            
            // 用户名是否有效 -> 密码输入框是否可用
            usernameValid
                .bind(to: testField1.rx.isEnabled)
                .disposed(by: disposeBag)
        
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid
            .bind(to: testField1.rx.isHidden)
            .disposed(by: disposeBag)
        let number:Observable<Int> = Observable.create { observer -> Disposable in
            observer.onNext(0)
            observer.onCompleted()
            observer.onNext(1)
            observer.onCompleted()
            observer.onNext(2)
            observer.onCompleted()
            observer.onNext(3)
            observer.onCompleted()
            observer.onNext(4)
            observer.onCompleted()
            return Disposables.create()
        }
        
        number.subscribe(onNext:{value in
            print(value)
        }).disposed(by: disposeBag)

        func getRepo(_ repo:String) -> Single<[String:Any]> {
            return Single
            
            
        }
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

