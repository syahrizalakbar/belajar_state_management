// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:belajar_state_management/contoh/provider/form_product/form_product_provider.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FormProductPage extends StatefulWidget {
  final Produk? product;
  const FormProductPage({super.key, this.product});

  @override
  State<FormProductPage> createState() => _FormProductPageState();
}

class _FormProductPageState extends State<FormProductPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FormProductProvider(widget.product),
      child: Consumer<FormProductProvider>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("${value.isAddProduct ? "Add" : "Edit"} Product"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: value.nameController,
                  decoration: const InputDecoration(
                    labelText: "Nama Produk",
                    hintText: "Nama Produk",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: value.priceController,
                  decoration: const InputDecoration(
                    labelText: "Harga Produk",
                    hintText: "Harga Produk",
                  ),
                ),
                const SizedBox(height: 10),
                value.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (value.isAddProduct) {
                            value.addProduct(context);
                          } else {
                            value.updateProduct(context);
                          }
                        },
                        child: Text(value.isAddProduct ? "Add" : "Edit"),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
