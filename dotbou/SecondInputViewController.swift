//
//  SecondInputViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit
import Photos
import CoreData

class SecondInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var QuestionImageInput = ""
    var QuestionInput = ""
    var AnswerInput = ""
    var CategoryInput = ""
    
    @IBOutlet weak var QuestionImage: UIImageView!
    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var Answer: UITextField!
    @IBAction func Enter(_ sender: UIButton){
        
        QuestionInput = Question.text!
        AnswerInput = Answer.text!
        
        
//        // テキストフィールド付きアラート表示
//        let alert = UIAlertController(title: "ToDo", message: "文字を入力してください。", preferredStyle: .alert)
//        // OKボタンの設定
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
//            (action:UIAlertAction!) -> Void in
//            // OKを押した時入力されていたテキストを表示
//            if let textFields = alert.textFields {
//                // アラートに含まれるすべてのテキストフィールドを調べる
//                for textField in textFields {
                    //        AppDelegateのインスタンスを用意しておく
                    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //        エンティティを操作するためのオブジェクト
                    let viewContext = appDelegate.persistentContainer.viewContext
                    //        Dotappエンティティオブジェクトを作成
                    let Dotapp = NSEntityDescription.entity(forEntityName: "Dotapp", in: viewContext)
                    //        ToDoエンティティにレコード(行)を挿入するためのオブジェクトを作成
                    let newRecord = NSManagedObject(entity: Dotapp!, insertInto: viewContext)
                    //        追加したいデータ(txtTitleに入力された文字)のセット
//                    if textField.text! == "" || textField.text! == nil{
//                        print("nilが入っています。")
//                    }else{
                        newRecord.setValue(QuestionInput, forKey: "questionText")
                        newRecord.setValue(AnswerInput, forKey: "questionAnswer")
                        newRecord.setValue(QuestionImageInput, forKey: "questionImage")
                        newRecord.setValue(CategoryInput, forKey: "category")
                        newRecord.setValue(Date(), forKey: "timeNow")
                        
                        
                        //        レコード(行)の即時保存
                        do{
                            try viewContext.save()
                        }catch{
                        }
//                        print("右の文字が入る\(textField.text!)")
//
//
//                        self.todoTask.append(textField.text!)
//
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
//                        //Stringにしたい
//                        let detastring:String = formatter.string(from: Date())
//
//                        self.todoDeta.append(detastring)
//                        self.TableView.reloadData()
//
//                    }
            }

//        alert.addAction(okAction)
//        // キャンセルボタンの設定
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alert.addAction(cancelAction)
//        // テキストフィールドを追加
//        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
//            textField.placeholder = "テキスト"
//        })
//        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
//        // アラートを画面に表示
//        self.present(alert, animated: true, completion: nil)
    
    @IBAction func QuestionImageInput(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
            let controller = UIImagePickerController()
            
            controller.delegate = self
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //トリミング
            controller.allowsEditing = true
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: false, completion: nil)
            //UserDefaultから取り出す
            // ユーザーデフォルトを用意する
            let myDefault = UserDefaults.standard
            
            // データを取り出す
            let strURL = myDefault.string(forKey: "selectedPhotoURL")
            
            
            
            
            if strURL != nil{
                let url = URL(string: strURL as String!)
                var options:PHImageRequestOptions = PHImageRequestOptions()
                options.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                let manager: PHImageManager = PHImageManager()
                manager.requestImage(for: asset,targetSize: PHImageManagerMaximumSize,contentMode: .aspectFill,options: options) { (image, info) -> Void in
                    self.QuestionImage.image = image
                }
            }
        }
    }
    
    //カメラロールで写真を選んだ後
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        let strURL:String = assetURL.description
        print(strURL)
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        // データを書き込んで
        myDefault.set(strURL, forKey: "selectedPhotoURL")
        // 即反映させる
        myDefault.synchronize()
        //閉じる処理
        
        
        if strURL != nil{
            let url = URL(string: strURL as String!)
            var options:PHImageRequestOptions = PHImageRequestOptions()
            options.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: PHImageManagerMaximumSize,contentMode: .aspectFill,options: options) { (image, info) -> Void in
                self.QuestionImage.image = image
            }
        }
        imagePicker.dismiss(animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
//        QuestionImage.text = QuestionImageInput
        
        Question.text = QuestionInput
        
        Answer.text = AnswerInput
        
        var a = 1
        a = a + a
        var b = 1
        var c = a + b
        c = 0
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
