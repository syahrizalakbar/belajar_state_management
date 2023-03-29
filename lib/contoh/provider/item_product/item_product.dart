import 'package:belajar_state_management/contoh/provider/form_product/form_product_page.dart';
import 'package:belajar_state_management/contoh/provider/item_product/item_provider.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ItemProvider(),
      child: ListTile(
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
            Consumer<ItemProvider>(builder: (context, value, child) {
              return value.loadingDelete
                  ? const CircularProgressIndicator()
                  : IconButton(
                      onPressed: () {
                        value.deleteProduct(
                            widget.product.id, widget.onRefresh);
                      },
                      icon: const Icon(Icons.delete),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
