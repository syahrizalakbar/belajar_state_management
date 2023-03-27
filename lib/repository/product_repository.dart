import 'dart:convert';

import 'package:belajar_state_management/config/api_config.dart';
import 'package:belajar_state_management/model/produk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ProductRepository {
  late final Dio dio;

  ProductRepository() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  ///
  /// Dummy Loading buat belajar aja, biar loadingnya kelihatan
  ///
  Future<void> dummyLoading() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Produk>?> getProduk() async {
    await dummyLoading();
    try {
      Response res = await dio.get(ApiConfig.produk);
      List<Produk> data = produkFromJson(jsonEncode(res.data));
      return data;
    } on DioError catch (e) {
      /// TODO: Handle dio error here
    }

    return null;
  }

  Future<Produk?> addProduk(String nama, String harga) async {
    await dummyLoading();
    try {
      Response res = await dio.post(
        ApiConfig.produk,
        data: {
          "nama": nama,
          "harga": harga,
        },
      );
      Produk data = Produk.fromJson(res.data);
      return data;
    } on DioError catch (e) {
      /// TODO: Handle dio error here
    }

    return null;
  }

  Future<Produk?> updateProduk(id, String nama, String harga) async {
    await dummyLoading();
    try {
      Response res = await dio.put(
        "${ApiConfig.produk}/$id",
        data: {
          "nama": nama,
          "harga": harga,
        },
      );
      Produk data = Produk.fromJson(res.data);
      return data;
    } on DioError catch (e) {
      /// TODO: Handle dio error here
    }

    return null;
  }

  Future<bool> deleteProduk(id) async {
    await dummyLoading();
    try {
      Response res = await dio.delete("${ApiConfig.produk}/$id");
      return res.statusCode == 200;
    } on DioError catch (e) {
      /// TODO: Handle dio error here
    }

    return false;
  }
}
