// To parse this JSON data, do
//
//     final produk = produkFromJson(jsonString);

import 'dart:convert';

List<Produk> produkFromJson(String str) =>
    List<Produk>.from(json.decode(str).map((x) => Produk.fromJson(x)));

String produkToJson(List<Produk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produk {
  Produk({
    this.nama,
    this.harga,
    this.id,
  });

  String? nama;
  String? harga;
  int? id;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        nama: json["nama"],
        harga: json["harga"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "id": id,
      };
}
