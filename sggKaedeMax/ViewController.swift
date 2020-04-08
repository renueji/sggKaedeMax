//
//  ViewController.swift
//  sggKaedeMax
//
//  Created by Rentaro on 2020/01/29.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //出発場所と行き先のピッカービューを生成
    var fromPickerView: UIPickerView = UIPickerView()
    var toPickerView: UIPickerView = UIPickerView()
    
    //時間を表すデータピッカーを生成
    var jikandp: UIDatePicker = UIDatePicker()
    
    //全ての駅のリストを配列で用意
    let ekiList =  ["久我山駅", "久我山駅入り口", "馬車道", "人見街道", "富士見ヶ丘", "新田緑通り", "西宮中学校南", "杉並希望の家", "西高校南", "西高校西門前", "宮前四丁目", "五日市街道", "宮前ふれあいの家北", "西荻南一丁目", "神明通り", "宮前三郵便局前", "南荻窪区民農園前" ,"天祖神社前", "南荻窪三丁目", "西荻南四丁目", "西荻南三丁目", "西荻マイロード入口", "桃井第三小学校", "甲田医院前", "西荻窪駅"]
    
    //3つのテキストフィールドとGoボタンをコードと接続
    @IBOutlet weak var busFrom: UITextField!
    @IBOutlet weak var busTo: UITextField!
    @IBOutlet weak var deruTime: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //始めに設定されているべき文字列型を設定
        self.busFrom.text = "久我山駅"
        self.busTo.text = "久我山駅"
        self.deruTime.text = "10:40"
        
        //Goボタンの外観や文字のスペースを設定
        self.goButton.layer.cornerRadius = 30
        self.goButton.setTitleColor(UIColor.red, for: .highlighted)
        self.goButton.contentVerticalAlignment = .fill
        self.goButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //pickerviewにタグ1を割り振る
        fromPickerView.tag = 1
        //委任先を自分自身に設定
        fromPickerView.delegate = self
        fromPickerView.dataSource = self
        
        //pickerviewをタグ2を割り振る
        toPickerView.tag = 2
        //こちらも委任先を自分自身に設定
        toPickerView.delegate = self
        toPickerView.delegate = self

        //ツールバーを生成していくよ
        let myToolbar1 = UIToolbar(frame: CGRect(x:0, y:0, width:0, height: 35))
        //「done」ボタンの実装
        let doneItem1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1(_:)))
        //「cancel」ボタンの実装
        let cancelItem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel1))
        
        //ツールバーにアイテム（doneとcancel）をセット！
        myToolbar1.setItems([cancelItem1, doneItem1], animated: true)
        
        //ツールバーを生成。cgrectのくだり
        let myToolbar2 = UIToolbar(frame: CGRect(x:0, y:0, width:0, height: 35))
        //「done」ボタンの実装
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done2(_:)))
        //「cancel」ボタンの実装
        let cancelItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel2))
        
        //ツールバーにアイテムをセット！
        myToolbar2.setItems([cancelItem2, doneItem2], animated: true)
        
        //出る駅を表示させるテキストフィールドにピッカービューとアイテムを追加
        self.busFrom.inputView = fromPickerView
        self.busFrom.inputAccessoryView = myToolbar1
        
        //着く駅のほうも同じように設定
        self.busTo.inputView = toPickerView
        self.busTo.inputAccessoryView = myToolbar2
        
        //ピッカーの時間単位の設定
        jikandp.datePickerMode = UIDatePicker.Mode.time
        jikandp.timeZone = NSTimeZone.local
        jikandp.locale = Locale.current
        deruTime.inputView = jikandp
        
        //決定バーを作るよ！
        let myToolbar3 = UIToolbar(frame: CGRect(x: 0, y:0 ,width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePush))
        myToolbar3.setItems([spaceItem, doItem], animated: true)
        
        //紐付いているテキストフィールドに値をセット！
        deruTime.inputView = jikandp
        deruTime.inputAccessoryView = myToolbar3
    }
    
    //pickerviewの必須メソッドその1（ピッカービューの列の数を設定）
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        //pickerviewの必須メソッドその2（ピッカービューの要素と全ての数）
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //今いる駅と行き先駅と、先程設定したタグを用いてif文で分ける
        if pickerView.tag == 1 {
            return ekiList.count
        } else {
            return ekiList.count
        }
    }
    
    //pickerviewの必須メソッドその3（ピッカービューに表示する配列を設定）
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //こちらも今いる駅と行き先駅とをタグで分ける
        if pickerView.tag == 1 {
            return ekiList[row]
        } else {
            return ekiList[row]
        }
    }
    
    //ユーザーがコンポーネント内の行を選択したとき、ピッカービューによって呼び出されるメソッド
    func pickerView(_ pickerView:UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.busFrom.text = ekiList[row]
        } else {
            self.busTo.text = ekiList[row]
        }
    }
    
    //今いる駅選択のときのキャンセルボタンの挙動設定
    @objc func cancel1() {
        self.busFrom.text = ""
        self.busFrom.endEditing(true)
    }
    
    //向かう駅選択のときのキャンセルボタンの挙動設定
    @objc func cancel2() {
        self.busTo.text = ""
        self.busTo.endEditing(true)
    }
    
    //今いる駅選択のときのdoneボタンの挙動設定
    @objc func done1(_ sender: UIBarButtonItem) {
        self.busFrom.endEditing(true)
    }
    
    //向かう駅選択のときのdoneボタンの挙動設定
    @objc func done2(_ sender: UIBarButtonItem) {
        self.busTo.endEditing(true)
    }
    
    //時間選択のdoneボタンの挙動設定！UIDatePickerのdoneを押したら発火！
    @objc func donePush() {
        self.deruTime.endEditing(true)
    //日付のフォーマット
    let formatter = DateFormatter()
    //出力の仕方を自由に変更！
        formatter.dateFormat = "HH:mm";
    
    //(from: datePicker.date)を指定することで、datePickerで指定した日時が表示される
        deruTime.text = "\(formatter.string(from: jikandp.date))"
    
    }
    
    //今いる駅と行き先駅の両方を交換するボタンの設定
    @IBAction func tapKuruKuru(_ sender: UIButton) {
        let motoBusFrom = self.busFrom.text
        self.busFrom.text = self.busTo.text
        self.busTo.text = motoBusFrom
    }
    
    //画面遷移処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.deruTime.endEditing(true)
        self.busFrom.endEditing(true)
        self.busTo.endEditing(true)
        
        //次の画面にデータを渡す。全ての要素が空っぽでなければ、時間と今いる場所・行き先を次の画面に渡す
        if deruTime.text != nil && busFrom.text != nil && busTo.text != nil {
            
            let controller = segue.destination as! KaedeResultViewController
            controller.ukeTime = deruTime.text!
            
            controller.deruBasho = busFrom.text!
            controller.tsukuBasho = busTo.text!
            controller.deruBasho2 = busFrom.text!
            controller.tsukuBasho2 = busTo.text!
            
        } else {
            print("エラーです")
        }
    }
    
}




