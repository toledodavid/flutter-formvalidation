//import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formvalidation/src/models/product_model.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;


class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}


class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductsBloc productsBloc;

  ProductModel product = new ProductModel();

  bool _saving = false;

  PickedFile photo;

  @override
  Widget build(BuildContext context) {

    productsBloc = Provider.productsBloc(context);

    final ProductModel productArgument = ModalRoute.of(context).settings.arguments;

    if (productArgument != null) {
      product = productArgument;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectImage
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto
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
                _showImage(),
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
      onPressed: (_saving) ? null : () => _submit(context), 
    );
  }

  void _submit(BuildContext context) async {
    if (!formKey.currentState.validate()) return;

    FocusScope.of(context).unfocus();

    formKey.currentState.save();

    // print(product.title);
    // print(product.price);
    // print(product.available);

    setState(() {
      _saving = true;
    });

    if (photo != null) {
      product.photoUrl = await productsBloc.uploadImage(File(photo.path));
    }

    if (product.id == null) {
      productsBloc.addProduct(product);
    } else {
      productsBloc.editProduct(product);
    }

    showSnackBar('Product saved');
  
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pop(context);
    });
  }

  showSnackBar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }


  Widget _showImage() {
    if (product.photoUrl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(product.photoUrl),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {

      if (photo != null) {
        return Image.file(
          File(photo.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return Image(
          image: AssetImage('assets/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover,
        );
      }
    }
  }

  _selectImage() {
    _imagePicker(ImageSource.gallery);
  }

  _takePhoto() {
    _imagePicker(ImageSource.camera);
  }

  _imagePicker(ImageSource type) async {
    final _picker = ImagePicker();
    final pickedImage = await _picker.getImage(source: type);

    // Catch error when user cancel selection of image
    try {
      photo = PickedFile(pickedImage.path);
    } catch (err) {
      print('$err');
    }

    if (photo != null) {
      // Clear
      product.photoUrl = null;
    }
 
    setState(() {});
  }
}