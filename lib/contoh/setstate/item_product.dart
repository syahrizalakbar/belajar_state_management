import 'package:belajar_state_management/contoh/setstate/form_product_page.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';

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
                          FormProductPage(product: widget.product))));
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
