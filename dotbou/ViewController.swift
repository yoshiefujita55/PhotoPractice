//
//  ViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/01/26.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var myPicker: UIPickerView!
    
    override func viewDidLoad() {
        myPicker.delegate = self
        myPicker.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    タイマーの値の配列
    var min = ["180","300","600"]
//    選択した配列の値
    var targetMin = "5"
    
    
//    列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return min.count
    }
    
//    表示する文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return min[row]
    }
    
//    PickerViewが選択された時の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print (min[row])
        targetMin = min[row]
        print (targetMin)
    }
    
//    segueを設定して画面移動
    @IBAction func buttonStart(_ sender: UIButton) {
        performSegue(withIdentifier: "start", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dvc = segue.destination as! SecondViewController
        dvc.takeTime = targetMin
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

