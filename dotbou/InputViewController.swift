
//
//  InputViewController.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/02/23.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    @IBOutlet weak var CategoryName: UITextField!
    
    @IBAction func NewQuestionInput(_ sender: UIButton) {
        input = CategoryName.text!
        var input2 = " "
        
        if CategoryName.text == "" || input.contains(input2){
            CategoryName.placeholder = "カテゴリー名を入力"
        }else{
            performSegue(withIdentifier: "Question1", sender: nil)
        }
    }
    
    //    遷移先からデータを取得
    var input = ""
    
    //    segueを使ったデータの移動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Question1"{
                let guest = segue.destination as!SecondTableViewController
                input = CategoryName.text!
                guest.input1 = input
        }
    }

    override func viewDidLoad() {
        
        CategoryName.text = input
        
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
