import 'package:belajar_state_management/contoh/setstate/item_product.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/contoh/setstate/form_product_page.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductRepository productRepo = ProductRepository();
  bool loading = true;
  List<Produk> listProduct = [];

  Future<void> getProduct() async {
    setState(() {
      loading = true;
    });
    List<Produk>? products = await productRepo.getProduk();
    setState(() {
      loading = false;
      listProduct = products ?? [];
    });
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Page: Set State"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const FormProductPage())));
          if (result == "refresh") {
            getProduct();
          }
        },
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listProduct.isEmpty
              ? const Center(
                  child: Text("NO DATA"),
                )
              : ListView.builder(
                  itemCount: listProduct.length,
                  itemBuilder: ((context, index) {
                    Produk product = listProduct[index];

                    return ItemProduct(
                      product,
                      onRefresh: () {
                        getProduct();
                      },
                    );
                  }),
                ),
    );
  }
}
