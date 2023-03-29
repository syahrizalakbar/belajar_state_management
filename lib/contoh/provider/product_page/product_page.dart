import 'package:belajar_state_management/contoh/provider/item_product/item_product.dart';
import 'package:belajar_state_management/contoh/provider/product_page/product_provider.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/contoh/provider/form_product/form_product_page.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductProvider? value;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Page: Provider"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const FormProductPage())));
            if (result == "refresh") {
              value?.getProduct();
            }
          },
        ),
        body: Consumer<ProductProvider>(builder: (context, value, child) {
          this.value = value;

          return value.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.listProduct.isEmpty
                  ? const Center(
                      child: Text("NO DATA"),
                    )
                  : ListView.builder(
                      itemCount: value.listProduct.length,
                      itemBuilder: ((context, index) {
                        Produk product = value.listProduct[index];

                        return ItemProduct(
                          product,
                          onRefresh: () {
                            value.getProduct();
                          },
                        );
                      }),
                    );
        }),
      ),
    );
  }
}
