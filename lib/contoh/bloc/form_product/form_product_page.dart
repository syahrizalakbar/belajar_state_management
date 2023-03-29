// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:belajar_state_management/contoh/bloc/form_product/form_product_bloc.dart';
import 'package:belajar_state_management/contoh/bloc/form_product/form_product_event.dart';
import 'package:belajar_state_management/contoh/bloc/form_product/form_product_state.dart';
import 'package:belajar_state_management/contoh/bloc/product_page/product_event.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:belajar_state_management/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        } else if (state is FormProductError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
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
                ] else if (state is FormProductError) ...[
                  Text(state.error),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      if (bloc.isAddProduct) {
                        bloc.add(AddProduct());
                      } else {
                        bloc.add(EditProduct());
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
