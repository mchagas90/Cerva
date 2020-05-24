//
//  ViewController.swift
//  Cerva
//
//  Created by Marcio Chagas on 23/05/20.
//  Copyright © 2020 Marcio Chagas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quantidadeField: UITextField!
    @IBOutlet weak var precoField: UITextField!
    @IBOutlet weak var resultadosTextView: UITextView!

    var listaPrecos: [Dictionary<String, Any>] = [] {
        didSet {
            resultadosTextView.text = montarInfos()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quantidadeField.delegate = self
        precoField.delegate = self

        resultadosTextView.isEditable = false;
    }

    @IBAction func clicouReiniciar(_ sender: Any) {
        listaPrecos = []
    }

    @IBAction func clicouAcao(_ sender: Any) {
        // evitar erros com preco vindo com virgula
        let preco: Double = Double(precoField.text!.replacingOccurrences(of: ",", with: ".")) ?? 0
        let quantidade: Int = Int(quantidadeField.text!) ?? 0

        if preco == 0 || quantidade == 0 {
            return
        }

        resignResponder()

        let precoLitro = calcularPrecoLitro(preco, quantidade)

        listaPrecos.append(
            ["preco": preco, "quantidade": quantidade, "precoLitro": precoLitro]
        )
        ordernarMelhorPreco()

        limparCampos()
    }

    func limparCampos() {
        quantidadeField.text = ""
        precoField.text = ""
    }

    func montarInfos() -> String {
        var resultados = ""
        for (index, resultado) in listaPrecos.enumerated() {
            let preco = resultado["preco"] as! Double
            let quantidade: Int = resultado["quantidade"] as! Int
            let precoLitro: Double = resultado["precoLitro"] as! Double

            let index = index + 1

            resultados += "\(index) - ml: \(quantidade), preço: \(preco.dinheiroString) - \(precoLitro.dinheiroString)\n\n"
        }
        return resultados
    }

    func ordernarMelhorPreco() {
        listaPrecos.sort(
            by: {
                (($0)["precoLitro"] as! Double) < (($1)["precoLitro"] as! Double)
            }
        )
    }

    func calcularPrecoLitro(_ preco: Double, _ quantidade: Int) -> Double {
        let resultado = (preco / Double(quantidade)) * 1000
        return resultado
    }

    func resignResponder() {
        quantidadeField.resignFirstResponder()
        precoField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignResponder()
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
