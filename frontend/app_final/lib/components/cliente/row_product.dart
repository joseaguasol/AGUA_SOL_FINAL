import 'package:flutter/material.dart';

class ProductCustom extends StatelessWidget {

  final String image;
  final String descripcion;
  final int contador;
  final VoidCallback? onPressedplus;
  final VoidCallback? onPressedminus;

  const ProductCustom({
    super.key,
    required this.image,
    required this.contador,
    required this.descripcion,
    this.onPressedplus,
    this.onPressedminus,
    
  });

  @override
  Widget build(BuildContext context) {

    
    return Row(
      children: [
        Container(
          height: 100,
          width: 90,
          //color:Colors.amber,
          child: Image.asset(image,width: 20,
          ),
        ),
    
        Expanded(
          child: Container(
            
            //color:Colors.blue,
            height: 100,
            alignment:Alignment.center,
              
              child:
            Text(descripcion,style:TextStyle(color:Colors.grey,fontSize:14,fontWeight: FontWeight.w300),),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
           // color: Colors.blue,
          ),
          //color:Colors.blue,
          child: Row(
            children: [
              IconButton(onPressed:   onPressedminus,
                icon:Icon(Icons.remove_circle_outline),
                iconSize: 40,
                color: const Color.fromARGB(255, 195, 120, 208),
               ),
               Container(
                height: 45,
                width: 30,
                
                //color: Colors.blue,
                child:Center(
                  child:FittedBox(
                    child:Text("$contador",style: TextStyle(color:Colors.blue,fontSize:30,fontWeight: FontWeight.w300),
                    )))
                 
               ),
              
               IconButton(onPressed: onPressedplus,
                icon: Icon(Icons.add_circle_outline),
                iconSize: 40,
                color:Colors.amber,
                )
            ],
          ),
        ),
      ],
    );
  }
}