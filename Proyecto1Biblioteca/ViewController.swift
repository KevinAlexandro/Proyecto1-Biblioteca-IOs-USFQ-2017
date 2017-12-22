//
//  ViewController.swift
//  Proyecto1Biblioteca
//
//  Created by user130165 on 9/1/17.
//  Copyright © 2017 KevinGonzalez. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //arreglo que guarda los libros
    var arrLibros = [Libro]()
    //arreglo que guarda los codigos
    var arrCodigos = [String]()
    
    //TextFields enlazados.
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtEditorial: UITextField!
    
    //Botones
    @IBOutlet weak var btnActualizar: UIButton!
    
    
    //UItextview
    @IBOutlet weak var tvLibros: UITextView!
    
    //Ocultar teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }//fin ocultar teclado
    
    @IBAction func AddLibro(_ sender: UIButton) {
        var codigoValido = true
        if (txtCodigo.text=="")
        {
            codigoValido = false
            tvLibros.text = "Ingrese un codigo"
        }
        
        for k in 0..<arrCodigos.count
        {
            if(txtCodigo.text == arrCodigos[k])
            {
                codigoValido = false
                tvLibros.text = "Codigo no unico"
            }
        }
        
        if (codigoValido) //si el codigo no se repite o no esta en blanco
        {
            //se crea un libro vacio
            let newLibro = Libro()
            
            if (txtTitulo.text != "")
            {
                newLibro.titulo = txtTitulo.text!
            }
            if (txtCodigo.text != "")
            {
                newLibro.codigo = txtCodigo.text!
                arrCodigos.append(txtCodigo.text!) //lleno arreglo con los codigos
            }
            else
            {
                arrCodigos.append("No codigo")
            }
            if (txtAutor.text != "")
            {
                newLibro.autor = txtAutor.text!
            }
            if (txtEditorial.text != "")
            {
                newLibro.editorial = txtEditorial.text!
            }
            
            arrLibros.append(newLibro) //agregar libro al arreglo
            
            //limpio campos donde se ingresaron datos
            txtCodigo.text = ""
            txtAutor.text=""
            txtEditorial.text=""
            txtTitulo.text=""
            tvLibros.text = ""

        }
        
        tvLibros.isUserInteractionEnabled = false //el usuario no puede escribir en el TV
        btnActualizar.isEnabled = false //el usuario no puede actualizar a menos que presione ver todo
                
    }//fin addLibro
    
    @IBAction func BuscarPorCodigo(_ sender: UIButton) {
        
        tvLibros.isUserInteractionEnabled = false
        btnActualizar.isEnabled = false
        
        let currentCode = txtCodigo.text!
        var ResultadoBusqueda = "Resultado de la busqueda:\n"
        var LibroEncontrado = false
        if  (currentCode != "") //para hacer la busqueda el espacio del codigo debe estar vacio
        {
            for j in 0 ..< arrCodigos.count //se busca en todo el arreglo de codigos
            {
                if(currentCode == arrCodigos[j])
                {
                    ResultadoBusqueda = ResultadoBusqueda + arrLibros[j].titulo+"-"+arrLibros[j].autor+"-"+arrLibros[j].codigo+"-"+arrLibros[j].editorial+"\n"
                    LibroEncontrado=true
                }
            }
            if(!LibroEncontrado)
            {
                ResultadoBusqueda = ResultadoBusqueda + "Libro no encontrado con codigo \(currentCode)"
            }
            tvLibros.text=ResultadoBusqueda //se imprime el resultado de la busqueda en el text view
        }
    }//fin BuscarPorCodigo
    
    @IBAction func verTodo(_ sender: UIButton) {
        var txtParaMostrar:String=""
        for i in 0  ..< arrLibros.count
        {
            txtParaMostrar = txtParaMostrar + arrLibros[i].titulo+"-"+arrLibros[i].autor+"-"+arrLibros[i].codigo+"-"+arrLibros[i].editorial+"\n"
        }
        tvLibros.text=txtParaMostrar
        tvLibros.isUserInteractionEnabled = true
        //se habilita el boton actualizar
        btnActualizar.isEnabled = true
        
    }// fin verTodo
    
    @IBAction func BorrarTodo(_ sender: UIButton) {
        btnActualizar.isEnabled = false
        tvLibros.isUserInteractionEnabled = false
        arrLibros.removeAll()
        arrCodigos.removeAll()
        tvLibros.text = ""
    }//fin BorrarTodo
    
    //inicio actualizar
    @IBAction func Actualizar(_ sender: UIButton) {
        let librosActualizados = tvLibros.text!
        //se borra informacion anterior
        arrLibros.removeAll()
        arrCodigos.removeAll()
        //separacion del String
        let librosActualizadosArr = librosActualizados.components(separatedBy: "\n") //separo cada salto de linea
        
        for i in 0 ..< (librosActualizadosArr.count - 1)
        {
            //separo cada vez que hay -
            var partesLibrosActualizadosArr  = librosActualizadosArr[i].components(separatedBy: "-")
            
            //Se almacena de nuevo la info actualizada
            let newLibro = Libro()
            newLibro.titulo = partesLibrosActualizadosArr[0]
            newLibro.autor = partesLibrosActualizadosArr[1]
            newLibro.codigo = partesLibrosActualizadosArr[2]
            newLibro.editorial = partesLibrosActualizadosArr[3]
            arrLibros.append(newLibro)
            arrCodigos.append(partesLibrosActualizadosArr[2])
            
        }
    }
    
    
    
}//fin class View Controller

class Libro {
    var titulo="No titulo"
    var codigo = "No codigo"
    var autor = "No autor"
    var editorial =  "No editorial"
}

