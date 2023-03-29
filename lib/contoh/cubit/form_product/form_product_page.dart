// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:belajar_state_management/contoh/cubit/form_product/form_product_bloc.dart';
import 'package:belajar_state_management/contoh/cubit/form_product/form_product_state.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormProductPage extends StatefulWidget {
  final Produk? product;
  const FormProductPage({super.key, this.product});

  @override
  State<FormProductPage> createState() => _FormProductPageState();
}

class _FormProductPageState extends State<FormProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormProductBloc(widget.product),
      child: BlocConsumer<FormProductBloc, FormProductState>(
          listener: (context, state) {
        if (state is FormProductSuccess) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context, "refresh");
          });
        }
      }, builder: (context, state) {
        final bloc = context.read<FormProductBloc>();

        return Scaffold(
          appBar: AppBar(
            title: Text("${bloc.isAddProduct ? "Add" : "Edit"} Product"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: bloc.nameController,
                  decoration: const InputDecoration(
                    labelText: "Nama Produk",
                    hintText: "Nama Produk",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: bloc.priceController,
                  decoration: const InputDecoration(
                    labelText: "Harga Produk",
                    hintText: "Harga Produk",
                  ),
                ),
                const SizedBox(height: 10),
                if (state is FormProductSaving) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ] else if (state is FormProductSuccess) ...[
                  const Icon(Icons.check, color: Colors.green),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      if (bloc.isAddProduct) {
                        bloc.addProduct();
                      } else {
                        bloc.updateProduct();
                      }
                    },
                    child: Text(bloc.isAddProduct ? "Add" : "Edit"),
                  )
                ]
              ],
            ),
          ),
        );
      }),
    );
  }
}
