import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/providers/products_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final productProvider = new ProductsProvider();

  ProductModel product = new ProductModel();

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
            key: formKey,
            child: Column(
              children: <Widget>[
                _createProductName(),
                _createProductPrice(),
                _createAvailable(),
                _createButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createProductName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (value) => product.title = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Type product name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createProductPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      onSaved: (value) => product.price = double.parse(value),
      validator: (value) {
        
        if (utils.isANumber(value)) {
          return null;
        } else {
          return 'Only numbers';
        }

      },
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          product.available = value;
        });
      }
    );
  }

  Widget _createButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: () => _submit(context), 
    );
  }

  void _submit(BuildContext context) {
    if (!formKey.currentState.validate()) return;

    FocusScope.of(context).unfocus();

    formKey.currentState.save();

    print(product.title);
    print(product.price);
    print(product.available);

    productProvider.createProduct(product);

  }
}