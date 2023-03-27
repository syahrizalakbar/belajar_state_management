import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/pages/setstate/form_product.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

class SetStatePage extends StatefulWidget {
  const SetStatePage({super.key});

  @override
  State<SetStatePage> createState() => _SetStatePageState();
}

class _SetStatePageState extends State<SetStatePage> {
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
        title: const Text("Set State"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const FormProduct())));
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

class ItemProduct extends StatefulWidget {
  final Produk product;
  final void Function() onRefresh;

  const ItemProduct(
    this.product, {
    super.key,
    required this.onRefresh,
  });

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool loadingDelete = false;

  Future<void> deleteProduct(id) async {
    setState(() {
      loadingDelete = true;
    });
    bool deleted = await ProductRepository().deleteProduk(id);
    setState(() {
      loadingDelete = false;
    });
    if (deleted) {
      widget.onRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.nama ?? ""),
      subtitle: Text("Rp ${widget.product.harga}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          FormProduct(product: widget.product))));
              if (result == "refresh") {
                widget.onRefresh();
              }
            },
            icon: const Icon(Icons.edit),
          ),
          loadingDelete
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: () {
                    deleteProduct(widget.product.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
        ],
      ),
    );
  }
}
