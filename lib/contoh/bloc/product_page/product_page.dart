import 'package:belajar_state_management/contoh/bloc/form_product/form_product_page.dart';
import 'package:belajar_state_management/contoh/bloc/item_product/item_product_page.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_bloc.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_event.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
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
      create: (context) => ProductBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Page: Bloc"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const FormProductPage())));
            if (result == "refresh") {
              bloc?.add(GetProduct());
            }
          },
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          bloc = context.read<ProductBloc>();

          if (state is ProductInitial) {
            bloc?.add(GetProduct());
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

          if (state is ProductSuccess) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: ((context, index) {
                Produk product = state.products[index];

                return ItemProductPage(
                  product,
                  onRefresh: () {
                    bloc?.add(GetProduct());
                  },
                );
              }),
            );
          }

          return Container();
        }),
      ),
    );
  }
}
