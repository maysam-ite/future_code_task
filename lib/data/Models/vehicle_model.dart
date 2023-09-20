class VehicleModel {
  int id;
  int vehicleTypeId;
  int userId;
  String model;
  String color;
  int boardNumber;
  String vehicleImage;
  String mechanicImage;
  String boardImage;
  String idImage;
  String delegateImage;
  String createdAt;
  String updatedAt;
  Type type;

  VehicleModel({
    required this.id,
    required this.vehicleTypeId,
    required this.userId,
    required this.model,
    required this.color,
    required this.boardNumber,
    required this.vehicleImage,
    required this.mechanicImage,
    required this.boardImage,
    required this.idImage,
    required this.delegateImage,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      vehicleTypeId: json['vehicle_type_id'],
      userId: json['user_id'],
      model: json['model'],
      color: json['color'],
      boardNumber: json['board_number'],
      vehicleImage: json['vehicle_image'],
      mechanicImage: json['mechanic_image'],
      boardImage: json['board_image'],
      idImage: json['id_image'],
      delegateImage: json['delegate_image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: Type.fromJson(json['type']),
    );
  }
}

class Type {
  int id;
  String name;

  Type({
    required this.id,
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['name'],
    );
  }
}
