import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
   static const String id = '\productscreen';
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Product Information',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter Product Name',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              )
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Price',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              ),
              SizedBox(width: 20,),
              Flexible(child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Category',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              ),
            ],
          ),
          SizedBox(height: 15),
           TextFormField(
            decoration: InputDecoration(
              labelText: 'Discount price',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              )
            ),
          ),
          SizedBox(height: 20),
           TextFormField(
            decoration: InputDecoration(
              labelText: 'Description',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              )
            ),
          ),
          SizedBox(height: 20),
           TextFormField(
            decoration: InputDecoration(
              labelText: 'Add Size',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              )
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){},
            child: Container(
              width: MediaQuery.of(context).size.width -50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(9)
              ),
              child: Center(
                child: Text('Upload Product',style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}