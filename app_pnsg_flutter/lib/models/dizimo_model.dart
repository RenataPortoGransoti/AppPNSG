class DizimoModel {
  final String? chavePix;
  final String? qrCode;

  DizimoModel({this.chavePix, this.qrCode});

  factory DizimoModel.fromJson(Map<String, dynamic> json) {
    return DizimoModel(
      chavePix: json['chavePix'],
      qrCode: json['QRCode'],
    );
  }
}
