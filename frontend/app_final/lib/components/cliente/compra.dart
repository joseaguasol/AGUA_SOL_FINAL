import 'package:flutter/material.dart';
//import 'package:app_final/components/cliente/row_product.dart';

class Compra extends StatefulWidget {
  const Compra({Key? key}) : super(key: key);

  @override
  State<Compra> createState() => _Compra();
}

class _Compra extends State<Compra>{
    @override
    Widget build (BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Compras",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200),),centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text("Resumen de Compra"),
  Table(
  border: TableBorder.all(),
  columnWidths: {1: FractionColumnWidth(.2)},
  children: [
    
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 2",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 3",  // Corregido aquí
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 2",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 3",  // Corregido aquí
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 2",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 3",  // Corregido aquí
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 2",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.blue,
            child: Text(
              "Header 3",  // Corregido aquí
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
    // ... Resto del código
  ],
),
SizedBox(height: 20,),
Container(
  width:300,
  height: 100,
  color: Colors.orange,
),
                  
                  Text("HOLA"),
                  Text("HOLA"),
                  Text("HOLA"),

                ],
              ),
            
            ),
          ),
        ),
      );
    }
}