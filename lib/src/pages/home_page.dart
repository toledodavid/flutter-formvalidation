import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsBloc = Provider.productsBloc(context);
    productsBloc.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home page')
      ),
      body:_createProductsList(productsBloc),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createProductsList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {

          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => _creatItem(context, productsBloc, products[index])
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _creatItem(BuildContext context, ProductsBloc productsBloc, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container( 
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productsBloc.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (product.photoUrl == null) ?
              Image(image: AssetImage('assets/no-image.png')) :
              FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(product.photoUrl),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

            ListTile(
              title: Text('${product.title} - ${product.price}'),
              subtitle: Text('${product.id}'),
              onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
            ),
          ],
        ),
      )
    );
  }

  _createFloatingButton(BuildContext context) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'product'),
      );
    }
}