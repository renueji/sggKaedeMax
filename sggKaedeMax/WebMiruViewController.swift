//
//  WebMiruViewController.swift
//  sggKaedeMax
//
//  Created by Rentaro on 2020/02/09.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit
import SafariServices

class WebMiruViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Webページを表示させるための処理
        let url = URL(string: "https://www.city.suginami.tokyo.jp/guide/machi/jikoku/1014647.html")
        if let url = url {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
    //「もう一度Webを見る」ボタンが押されたとき、上の処理を再実行
    @IBAction func oneMoreButton(_ sender: UIButton) {
        self.viewDidLoad()
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
