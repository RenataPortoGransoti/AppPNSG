class DoacaoModel {
  final String? chavePix;
  final String? qrCode;

  DoacaoModel({this.chavePix, this.qrCode});

  factory DoacaoModel.fromJson(Map<String, dynamic> json) {
    return DoacaoModel(
      chavePix: json['chavePix'],
      qrCode: json['QRCode'],
    );
  }
}
