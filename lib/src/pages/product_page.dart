import 'package:flutter/material.dart';


class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {}
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: <Widget>[
                _createProductName(),
                _createProductPrice(),
                _createButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createProductName() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
    );
  }

  Widget _createProductPrice() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: () {}, 
    );
  }
}