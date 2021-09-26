class Barang {
  Barang({
    required this.idBarang,
    required this.namaBarang,
    required this.idPenjual,
    required this.foto,
    required this.hargaBarang,
  });

  int idBarang;
  String namaBarang;
  int idPenjual;
  String foto;
  int hargaBarang;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
      idBarang: json["idBarang"],
      namaBarang: json["namaBarang"].toString(),
      idPenjual: json["idPenjual"],
      foto: json["foto"].toString(),
      hargaBarang: json["hargaBarang"]);
}
