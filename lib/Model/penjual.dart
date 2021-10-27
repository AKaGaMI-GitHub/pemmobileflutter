class Penjual {
  Penjual({required this.idPenjual, required this.namaPenjual});
  int idPenjual;
  String namaPenjual;
  factory Penjual.fromJson(Map<String, dynamic> json) => Penjual(
      idPenjual: json["idPenjual"],
      namaPenjual:
          json["namaPenjual"] == null ? '' : json["namaPenjual"].toString());
  Map<String, dynamic> toJson() =>
      {"idPenjual": idPenjual, "namaPenjual": namaPenjual};
}
