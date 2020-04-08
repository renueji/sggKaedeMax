//
//  KaedeResultViewController.swift
//  sggKaedeMax
//
//  Created by Rentaro on 2020/02/09.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit

class KaedeResultViewController: UIViewController {
    
    //全ての駅をキーにして、バリューでナンバリングした辞書
    let zenEki =  ["久我山駅": 0, "久我山駅入り口": 1, "馬車道": 2, "人見街道": 3, "富士見ヶ丘": 4, "新田緑通り": 5, "西宮中学校南": 6, "杉並希望の家": 7, "西高校南": 8, "西高校西門前" :9, "宮前四丁目": 10, "五日市街道": 11, "宮前ふれあいの家北": 12, "西荻南一丁目": 13, "神明通り": 14, "宮前三郵便局前": 15, "南荻窪区民農園前": 16 ,"天祖神社前": 17, "南荻窪三丁目": 18, "西荻南四丁目": 19, "西荻南三丁目": 20, "西荻マイロード入口": 21, "桃井第三小学校": 22, "甲田医院前": 23, "西荻窪駅": 24]
    
//   //久我山から西荻窪に向かうときに利用可能な駅をキーにして、駅間の所要時間をバリューにした辞書
    let ekitachi = ["久我山駅": 0, "馬車道": 2, "人見街道": 3, "富士見ヶ丘": 4, "新田緑通り": 6, "西高校南": 7, "西高校西門前" :8, "宮前四丁目": 9, "五日市街道": 10, "宮前ふれあいの家北": 11, "西荻南一丁目": 12, "神明通り": 13, "宮前三郵便局前": 14, "南荻窪区民農園前": 15 ,"天祖神社前": 16, "南荻窪三丁目": 17, "西荻南三丁目": 18, "西荻マイロード入口": 19, "桃井第三小学校": 20, "西荻窪駅": 21]
    
    //西荻窪から久我山に向かうときに利用可能な駅をキーにして、駅間の所要時間をバリューにした辞書
    let ekitachi2 = ["西荻窪駅": 0, "甲田医院前": 2, "西荻南四丁目": 3, "神明通り": 4, "西荻南一丁目": 5, "宮前ふれあいの家北": 6, "五日市街道": 7, "宮前四丁目": 8, "西高校西門前": 9, "西高校南": 10, "杉並希望の家": 11, "西宮中学校南": 12, "久我山駅入口": 13, "久我山駅": 14]
    
    //久我山方面から西荻窪方面に向かうときの基準となる分数
    let kugayamakijun = [6, 26, 46]
    
    //西荻窪方面から久我山駅方面に向かうときの基準となる分数
    let nishiogikijun = [0, 20 ,40]
   
    //遷移前画面から受け取ったデータを格納する変数
    var ukeTime = "●●"
    var deruBasho = "久我山駅"
    var tsukuBasho = "西荻窪駅"
    var deruBasho2 = "西荻窪駅"
    var tsukuBasho2 = "久我山駅"
    
    //全てのラベルをコードに接続
    @IBOutlet weak var goJikan: UILabel!
    @IBOutlet weak var goWay: UILabel!
    @IBOutlet weak var tsukuJikanBasho: UILabel!
    @IBOutlet weak var kiwotsukete: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //文字列で受け取ったデータの上2桁をjikan定数として保持
        let jikan: String =
            String(ukeTime.prefix(2))
        //文字列で受け取ったデータの下2桁をhun定数として保持
        let hun: String =
            String(ukeTime.suffix(2))
        
        //それぞれをInt型に変換
        let jisu = Int(jikan)!
        let hunsu = Int(hun)!
        
        //久我山から西荻に向かうための処理
        if zenEki[deruBasho]! < zenEki[tsukuBasho]! {
            
            //久我山駅方面から西荻窪駅方面の移動で使えない駅が「今いる駅」に含まれていないかどうかチェックしながら…
            //「久我山駅」を基準としたときの、「今いる駅」までにかかる時間をtsukuban定数に格納
            //もし含まれていたら、その旨を表示
            guard let shutuban = ekitachi["\(deruBasho)"] else {
                self.goJikan.text = "残念…"
                self.goWay.text = "そこから\(tsukuBasho)には行けないんだ"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "一旦西荻窪駅に行ってみよう！"
                
                return
            }
            
            //久我山駅方面から西荻窪駅方面の移動で使えない駅が「着きたい駅」に含まれていないかどうかチェックしながら…
            //「久我山駅」を基準としたときの、「着きたい駅」までにかかる時間をtsukuban定数に格納
            //もし含まれていたら、その旨を表示
            guard let tsukuban = ekitachi["\(tsukuBasho)"] else {
                self.goJikan.text = "残念…"
                self.goWay.text = "そこから\(tsukuBasho)には行けないんだ"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "一旦西荻窪駅に行ってみよう！"
                
                return
            }
            
            //受け渡された「今いる駅」から出発したときの分数3パターンをnewkugayamakijunに格納
            let newkugayamakijun = kugayamakijun.map { ($0 + shutuban) % 60 }
            
            //終電の時間と始発の時間を設定
            let saishuu1 = "19" + ":" + "\(newkugayamakijun[2])"
            let shihatsu1 = "07" + ":" + "0" + "\(newkugayamakijun[0])"
            
            //受け取った時間が、終電よりも大きい（遅い）場合
            if ukeTime > saishuu1 {
                self.goJikan.text = "おいおい！"
                self.goWay.text = "もうすぎ丸はやってないよ！"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "諦めて歩いていきな！"
                
                return
            
            //受け取った時間が、始発よりも早い（小さい）場合
            } else if ukeTime < shihatsu1 {
                self.goJikan.text = "おいおい！"
                self.goWay.text = "まだすぎ丸はやってないよ！"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "諦めて歩いていきな！"
                
                return
            }
            
            //switch文を使い、どの分に乗ればよいのかを判定
            switch hunsu {
            
            case 0 ... newkugayamakijun[0]:
                self.goJikan.text = "\(jisu)時\(newkugayamakijun[0])分に"
                self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                let kakarujikan = tsukuban - shutuban
                self.tsukuJikanBasho.text = "\(jisu)時\(newkugayamakijun[0] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                
            case newkugayamakijun[0] ..< newkugayamakijun[1]:
                self.goJikan.text = "\(jisu)時\(newkugayamakijun[1])分に"
                self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                let kakarujikan = tsukuban - shutuban
                self.tsukuJikanBasho.text = "\(jisu)時\(newkugayamakijun[1] + kakarujikan)分に\(tsukuBasho)に着くよ！"
            
            case newkugayamakijun[1] ..< newkugayamakijun[2]:
                
                let hunhun = (tsukuban - shutuban) + newkugayamakijun[2]
                if hunhun > 60 {
                    let seikakuhun = hunhun - 60
                    self.goJikan.text = "\((jisu))時\(newkugayamakijun[2])分に"
                    self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(seikakuhun)分に\(tsukuBasho)に着くよ！"
                    
                } else {
                    self.goJikan.text = "\(jisu)時\(newkugayamakijun[2])分に"
                    self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                    let kakarujikan = tsukuban - shutuban
                    self.tsukuJikanBasho.text = "\(jisu)時\(newkugayamakijun[2] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                    
                }
            //分数が大きい場合、乗る時間を時間を一時間早める
            case newkugayamakijun[2] ..< 59:
                
                let hunhun = (tsukuban - shutuban) + newkugayamakijun[0]
                
                if hunhun > 60 {
                    let seikakuhun = hunhun - 60
                    self.goJikan.text = "\((jisu + 1))時\(newkugayamakijun[0])分に"
                    self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(newkugayamakijun[0] +  seikakuhun)分に\(tsukuBasho)に着くよ！"
                } else if hunhun <= 59 {
                    self.goJikan.text = "\(jisu + 1)時\(newkugayamakijun[0])分に"
                    self.goWay.text = "\(deruBasho)から西荻窪駅行きに乗れば…"
                    let kakarujikan = tsukuban - shutuban
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(newkugayamakijun[0] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                } else {
                   
                }
            
            default:
                print("例外")
            }
            
            
        }
            //西荻から久我山に向かうための処理
            else if zenEki[deruBasho]! > zenEki[tsukuBasho]! {
            
            //西荻窪駅方面から久我山駅方面の移動で使えない駅が「今いる駅」に含まれていないかどうかチェックしながら…
            //「西荻窪駅」を基準としたときの、「今いる駅」までにかかる時間をshutuban2定数に格納
            //もし含まれていたら、その旨を表示
            guard let shutuban2 = ekitachi2["\(deruBasho2)"] else {
                self.goJikan.text = "残念…"
                self.goWay.text = "そこから\(tsukuBasho2)には行けないんだ"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "一旦久我山駅に行ってみよう！"
                
                return
            }
            
            //西荻窪駅方面から久我山駅方面の移動で使えない駅が「今いる駅」に含まれていないかどうかチェックしながら…
            //「西荻窪駅」を基準としたときの、「今いる駅」までにかかる時間をtsukuban2定数に格納
            //もし含まれていたら、その旨を表示
            guard let tsukuban2 = ekitachi2["\(tsukuBasho2)"] else {
                self.goJikan.text = "残念…"
                self.goWay.text = "そこから\(tsukuBasho2)には行けないんだ"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "一旦久我山駅に行ってみよう！"
                
                return
            }
            
            //受け渡された「今いる駅」から出発したときの分数3パターンをnewkugayamakijunに格納
            let newnishiogikijun = nishiogikijun.map { ($0 + shutuban2) % 60 }
            
            //終電の時間と始発の時間を設定
            let saishuu2 = "19" + ":" + "\(newnishiogikijun[2])"
            let shihatsu2 = "07" + ":" + "0" + "\(newnishiogikijun[0])"
            
            //受け取った時間が、終電よりも大きい（遅い）場合
            if ukeTime > saishuu2 {
                self.goJikan.text = "おいおい！"
                self.goWay.text = "もうすぎ丸はやってないよ！"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "諦めて歩いていきな！"
                
                return
                
                //受け取った時間が、終電よりも小さい（早い）場合
            } else if ukeTime < shihatsu2 {
                self.goJikan.text = "おいおい！"
                self.goWay.text = "まだすぎ丸はやってないよ！"
                self.tsukuJikanBasho.text = ""
                self.kiwotsukete.text = "諦めて歩いていきな！"
                
                return
            }
            
            //switch文を使い、どの分に乗ればよいのかを判定
            switch hunsu {
                
            case 0 ... newnishiogikijun[0]:
                self.goJikan.text = "\(jisu)時\(newnishiogikijun[0])分に"
                self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                let kakarujikan = tsukuban2 - shutuban2
                self.tsukuJikanBasho.text = "\(jisu)時\(newnishiogikijun[0] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                
            case newnishiogikijun[0] ..< newnishiogikijun[1]:
                self.goJikan.text = "\(jisu)時\(newnishiogikijun[1])分に"
                self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                let kakarujikan = tsukuban2 - shutuban2
                self.tsukuJikanBasho.text = "\(jisu)時\(newnishiogikijun[1] + kakarujikan)分に\(tsukuBasho)に着くよ！"
            
            case newnishiogikijun[1] ..< newnishiogikijun[2]:
                
                let hunhun = (tsukuban2 - shutuban2) + newnishiogikijun[2]
                if hunhun > 60 {
                    let seikakuhun = hunhun - 60
                    self.goJikan.text = "\((jisu))時\(newnishiogikijun[2])分に"
                    self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(seikakuhun)分に\(tsukuBasho)に着くよ！"
                    
                } else {
                    self.goJikan.text = "\(jisu)時\(newnishiogikijun[2])分に"
                    self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                    let kakarujikan = tsukuban2 - shutuban2
                    self.tsukuJikanBasho.text = "\(jisu)時\(newnishiogikijun[2] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                    
                }
            
            case newnishiogikijun[2] ..< 59:
                
                let hunhun = (tsukuban2 - shutuban2) + newnishiogikijun[0]
                
                if hunhun > 60 {
                    let seikakuhun = hunhun - 60
                    self.goJikan.text = "\((jisu + 1))時\(newnishiogikijun[0])分に"
                    self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(newnishiogikijun[0] +  seikakuhun)分に\(tsukuBasho)に着くよ！"
                } else if hunhun <= 59 {
                    self.goJikan.text = "\(jisu + 1)時\(newnishiogikijun[0])分に"
                    self.goWay.text = "\(deruBasho)から久我山駅行きに乗れば…"
                    let kakarujikan = tsukuban2 - shutuban2
                    self.tsukuJikanBasho.text = "\(jisu + 1)時\(newnishiogikijun[0] + kakarujikan)分に\(tsukuBasho)に着くよ！"
                } else {
                   
                }
            
            default:
                print("例外")
                }
            
        }
        //もし「今いる駅」と「着きたい駅」が同じだった場合の処理
        else {
            self.goJikan.text = ""
            self.goWay.text = ""
            self.tsukuJikanBasho.text = ""
            self.kiwotsukete.text = "それどっちもおんなじ場所じゃない…？"
        }
        
        // Do any additional setup after loading the view.
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
