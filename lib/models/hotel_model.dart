class Hotel {
  int id;
  String uuid;
  String slug;
  String name;
  String phone;
  String fax;
  String email;
  String street;
  String zipcode;
  int latitude;
  int longitude;
  int builtYear;
  int lastRenovatedYear;
  String checkIn;
  String checkOut;
  int totalRooms;
  int floor;
  String thumbnail;
  String roomService;
  int breakfastCharge;
  String airportTransfer;
  int airportFee;
  String creditCard;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int brandId;
  int cityId;
  int scoreReview;
  dynamic minPriceRate;
  dynamic totalReview;
  dynamic cancellationPolicyEn;
  dynamic creditCardEn;
  dynamic descriptionEn;
  String status;
  String type;
  String website;
  int roomVoltage;
  String availableParking;
  String feeParking;
  int parkingCharge;
  String availableBreakfast;
  String feeBreakfast;
  int userId;
  int cancellationPolicyId;
  List<int> hotelFacId;

  Hotel({
    required this.id,
    required this.uuid,
    required this.slug,
    required this.name,
    required this.phone,
    required this.fax,
    required this.email,
    required this.street,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
    required this.builtYear,
    required this.lastRenovatedYear,
    required this.checkIn,
    required this.checkOut,
    required this.totalRooms,
    required this.floor,
    required this.thumbnail,
    required this.roomService,
    required this.breakfastCharge,
    required this.airportTransfer,
    required this.airportFee,
    required this.creditCard,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.brandId,
    required this.cityId,
    required this.scoreReview,
    required this.minPriceRate,
    required this.totalReview,
    required this.cancellationPolicyEn,
    required this.creditCardEn,
    required this.descriptionEn,
    required this.status,
    required this.type,
    required this.website,
    required this.roomVoltage,
    required this.availableParking,
    required this.feeParking,
    required this.parkingCharge,
    required this.availableBreakfast,
    required this.feeBreakfast,
    required this.userId,
    required this.cancellationPolicyId,
    required this.hotelFacId,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      fax: json['fax'] ?? '',
      email: json['email'] ?? '',
      street: json['street'] ?? '',
      zipcode: json['zipcode'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      builtYear: json['built_year'] ?? 0,
      lastRenovatedYear: json['last_renovated_year'] ?? 0,
      checkIn: json['check_in'] ?? '',
      checkOut: json['check_out'] ?? '',
      totalRooms: json['total_rooms'] ?? 0,
      floor: json['floor'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      roomService: json['room_service'] ?? '',
      breakfastCharge: json['breakfast_charge'] ?? 0,
      airportTransfer: json['airport_transfer'] ?? '',
      airportFee: json['airport_fee'] ?? 0,
      creditCard: json['credit_card'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
      brandId: json['brand_id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      scoreReview: json['score_review'] ?? 0,
      minPriceRate: json['min_price_rate'],
      totalReview: json['total_review'],
      cancellationPolicyEn: json['cancellation_policy_en'],
      creditCardEn: json['credit_card_en'],
      descriptionEn: json['description_en'],
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      website: json['website'] ?? '',
      roomVoltage: json['room_voltage'] ?? 0,
      availableParking: json['available_parking'] ?? '',
      feeParking: json['fee_parking'] ?? '',
      parkingCharge: json['parking_charge'] ?? 0,
      availableBreakfast: json['available_breakfast'] ?? '',
      feeBreakfast: json['fee_breakfast'] ?? '',
      userId: json['user_id'] ?? 0,
      cancellationPolicyId: json['cancellation_policy_id'] ?? 0,
      hotelFacId: List<int>.from(json['hotel_fac_id'] ?? []),
    );
  }
}
