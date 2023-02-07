// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_json_api/api/model.dart';
import 'package:flutter_json_api/method/method.dart';
import './api/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Providers providers = Providers();
  Map<String, dynamic>? product;
  ProductModel? dataProductModel;
  List<Product>? data;
  Method m = Method();
  bool? eksekusiBool;
  Map<String, dynamic>? eksekusi;
  bool isLoaded = true;

  @override
  void initState() {
    getDataAsync();
    super.initState();
  }

  void getDataAsync() async {
    product = await providers.getData();
    eksekusi = m.eksekusi(product: product);
    eksekusiBool = eksekusi!['error'];
    if (eksekusiBool == false) {
      dataProductModel = product?['data'];
      data = dataProductModel?.products;
      setState(() {
        isLoaded = false;
      });
    }

    print('map json === $eksekusiBool');
    // print('map api === ${data.length}');
  }

  // Map<String, dynamic>? product;

  // bool eksekusi() {
  //   if (product == null) {
  //     return true;
  //   }

  //   if (product!['error'] == true) {
  //     return true;
  //   }

  //   if (product!['data'] == null) {
  //     return true;
  //   }

  //   return false;
  // }

  int i = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // product = providers.getData();
        },
      ),
      body: (isLoaded)
          ? Center(
              // child: Text('${eksekusi!['message']}'),
              child: Text('awokow'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 0),
              // ignore: sort_child_properties_last
              child: ListView.separated(
                separatorBuilder: (context, i) => Divider(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  print('abc == $index');
                  Product dataProduct = data![index];
                  // return catalogDummy(dataProduct: dataProduct);
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey,
                    ),
                    title: Text(dataProduct.title),
                    subtitle: Text(dataProduct.price.toString()),
                  );
                },
              )),
    );
  }
}

class catalogDummy extends StatelessWidget {
  const catalogDummy({
    super.key,
    required this.dataProduct,
  });

  final Product dataProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, i) => const SizedBox(width: 12),
                  itemCount: dataProduct.images.length,
                  itemBuilder: (context, index) {
                    String images = dataProduct.images[1];
                    // ImagePoductDummy(
                    //   images: images,
                    // );
                  }),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              dataProduct.title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              '${dataProduct.price}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(
              '${dataProduct.stock}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              dataProduct.description,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePoductDummy extends StatelessWidget {
  const ImagePoductDummy({super.key, required this.images});

  final String images;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.dummyjson.com/data/products/1/1.jpg'))),
    );
  }
}
