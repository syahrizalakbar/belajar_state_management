import 'package:belajar_state_management/contoh/bloc/product_page/product_bloc.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_event.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/contoh/setstate/form_product_page.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ProductBloc()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Page: BloC"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const FormProductPage())));
            if (result == "refresh") {
              bloc?.add(GetListProduct());
            }
          },
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          bloc = context.read<ProductBloc>();

          if (state is ProductInitial) {
            bloc!.add(GetListProduct());
          }
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductEmpty) {
            return const Center(
              child: Text("NO DATA"),
            );
          }
          if (state is ProductError) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is ProductSuccess) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: ((context, index) {
                Produk product = state.products[index];

                return ItemProduct(
                  product,
                  onRefresh: () {
                    bloc?.add(GetListProduct());
                  },
                );
              }),
            );
          }

          return const Center(
            child: Text("Unhandled State"),
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
