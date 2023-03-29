// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FormProductPage extends StatefulWidget {
  final Produk? product;
  const FormProductPage({super.key, this.product});

  @override
  State<FormProductPage> createState() => _FormProductPageState();
}

class _FormProductPageState extends State<FormProductPage> {
  bool get isAddProduct => widget.product == null;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ProductRepository productRepo = ProductRepository();

  bool loading = false;

  Future<void> addProduct() async {
    setState(() {
      loading = true;
    });
    Produk? produk =
        await productRepo.addProduk(nameController.text, priceController.text);
    setState(() {
      loading = false;
    });
    if (produk != null) {
      Navigator.pop(context, "refresh");
    } else {
      log("Gagal Add");
    }
  }

  Future<void> updateProduct() async {
    setState(() {
      loading = true;
    });
    Produk? produk = await productRepo.updateProduk(
        widget.product!.id, nameController.text, priceController.text);
    setState(() {
      loading = true;
    });
    if (produk != null) {
      Navigator.pop(context, "refresh");
    } else {
      log("Gagal Update");
    }
  }

  @override
  void initState() {
    if (widget.product != null) {
      nameController.text = widget.product?.nama ?? "-";
      priceController.text = widget.product?.harga ?? "-";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${isAddProduct ? "Add" : "Edit"} Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                hintText: "Nama Produk",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Harga Produk",
                hintText: "Harga Produk",
              ),
            ),
            const SizedBox(height: 10),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (isAddProduct) {
                        addProduct();
                      } else {
                        updateProduct();
                      }
                    },
                    child: Text(isAddProduct ? "Add" : "Edit"),
                  ),
          ],
        ),
      ),
    );
  }
}
