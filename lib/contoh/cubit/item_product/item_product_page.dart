import 'package:belajar_state_management/contoh/cubit/form_product/form_product_page.dart';
import 'package:belajar_state_management/contoh/cubit/item_product/item_product_bloc.dart';
import 'package:belajar_state_management/contoh/cubit/item_product/item_product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProductPage extends StatefulWidget {
  final Produk product;
  final void Function() onRefresh;

  const ItemProductPage(
    this.product, {
    super.key,
    required this.onRefresh,
  });

  @override
  State<ItemProductPage> createState() => _ItemProductPageState();
}

class _ItemProductPageState extends State<ItemProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemProductBloc(),
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
            BlocConsumer<ItemProductBloc, ItemProductState>(
              listener: (BuildContext context, state) {
                if (state is ItemProductDeleted) {
                  Future.delayed(const Duration(seconds: 2), () {
                    widget.onRefresh();
                  });
                }
              },
              builder: (context, state) {
                final bloc = context.read<ItemProductBloc>();

                if (state is ItemProductDeleting) {
                  return const CircularProgressIndicator();
                }

                if (state is ItemProductDeleted) {
                  return const Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                }

                return IconButton(
                  onPressed: () {
                    if (widget.product.id != null) {
                      bloc.deleteProduct(widget.product.id!);
                    }
                  },
                  icon: const Icon(Icons.delete),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
