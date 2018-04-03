//
//  SecondViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/01/30.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit; import CoreData

class SecondViewController: UIViewController {

//    変数名
    var takeTime = "5"  //segueの初期値
    var timer = Timer()
    var startTime : Double = 0.0
    var QuestionText = [""]
    var Answers = [""]
    var rr = 0
    var QuestionIMG = [""]
    var takeCategory = ""
    
//    部品変数名
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var Answer: UITextField!
    
//    答えが入力された時の動作
    @IBAction func JudgedAnswer(_ sender: UITextField) {
        
        var AnswerText = Int(Answer.text!)

        if QuestionText.index(of: QuestionText[rr]) == Answers.index(of: Answers[rr]){
            if AnswerText == Int(Answers[rr]){
               Question.text = "Crear"
                
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    // 0.7秒後に実行したい処理
                    self.Answer.text = ""
                    var r = Int(arc4random())%self.Answers.count
                    self.QuestionImage.image = UIImage(named:"\(r).jpg")
                    self.Question.text = self.QuestionText[r]
                    self.rr = r
                    }
            }else{
            Question.text = "Not crear"
            Answer.text = ""
            }
        }
    }

    //MARK: 全メソッド
    @objc func updatelabel(){
        let elasedTime = Date().timeIntervalSince1970 - startTime
        let flooredTimer = Int(floor(elasedTime))
        let leftTime = Int(takeTime)! - flooredTimer
        let displayString = NSString(format:"00:%02d", leftTime)as String
        labelTimer.text = displayString
//        print(labelTimer.text)
        if labelTimer.text == "00:00" {
            timer.invalidate()
//            performSegue(withIdentifier: "end", sender: nil)
            
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "end")
            self.present(nextView, animated: false, completion: nil)
            }
        }
    
    //    データを取ります。
    func read(){
        //        カラの配列を用意します。
        QuestionText = []
        //        AppDelegateを使う準備
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //        エンティティを操作するためのオブジェクト
        let viewContext = appDelegate.persistentContainer.viewContext
        //        どのエンティティからデータを取得してくるか設定
        let fetchRequest:NSFetchRequest<Dotbou> = Dotbou.fetchRequest()
        //        let query: NSFetchRequest<Dotbou> = Dotbou.fetchRequest()
        let predicate = NSPredicate(format:"%K = %@","category", takeCategory)
        fetchRequest.predicate = predicate
        
        do{
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeNow",ascending: false)]
            //            データを一括取得
            let fetchResults = try viewContext.fetch(fetchRequest)
            //            データの取得
            for result: AnyObject in fetchResults {
                let text: String! = result.value(forKey: "questionText") as! String
                let IMG: String! = result.value(forKey: "questionImage") as! String
                let answer: String! = result.value(forKey: "questionAnswer") as! String
                let category:String!  = result.value(forKey: "category") as! String
                let timeNow:Date!  = result.value(forKey: "timeNow") as! Date
                print (timeNow)
//                //データ型をString型へ
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
                //Stringにしたい
//                let detastring:String = formatter.string(from: timeNow as Date)
                
                //            データの追加
                QuestionText.append(text)
//                a.append(detastring)
                Answers.append(answer)
                QuestionIMG.append(IMG)
                
                print(QuestionText)
                print(Answers)
                print(QuestionIMG)
            }
        }catch{
        }
    }
    
    
    override func viewDidLoad() {
        startTime = Date().timeIntervalSince1970 - startTime
        labelTimer.text = takeTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatelabel), userInfo: nil, repeats: true)
        print (takeTime,"びょう")
        labelTimer.text = takeTime
        
        var r = Int(arc4random())%Answers.count
        
        QuestionImage.image = UIImage(named:"\(r).jpg")
        Question.text = QuestionText[r]
        
        rr = r
    
        super.viewDidLoad()

        read()
        
        
        // Do any additional setup after loading the view.
    }

//    画面が表示される直前の処理
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
