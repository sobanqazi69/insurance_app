class InsuranceModel {
  final String id;
  final String companyName;
  final String premiumAmount;
  final String monthlyAmount;
  final String workshopCount;

  const InsuranceModel({
    required this.id,
    required this.companyName,
    required this.premiumAmount,
    required this.monthlyAmount,
    required this.workshopCount,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    try {
      return InsuranceModel(
        id: json['id']?.toString() ?? '',
        companyName: json['companyName']?.toString() ?? '',
        premiumAmount: json['premiumAmount']?.toString() ?? '',
        monthlyAmount: json['monthlyAmount']?.toString() ?? '',
        workshopCount: json['workshopCount']?.toString() ?? '',
      );
    } catch (e) {
      throw Exception('Error parsing InsuranceModel: $e');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'id': id,
        'companyName': companyName,
        'premiumAmount': premiumAmount,
        'monthlyAmount': monthlyAmount,
        'workshopCount': workshopCount,
      };
    } catch (e) {
      throw Exception('Error converting InsuranceModel to JSON: $e');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceModel &&
        other.id == id &&
        other.companyName == companyName &&
        other.premiumAmount == premiumAmount &&
        other.monthlyAmount == monthlyAmount &&
        other.workshopCount == workshopCount;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      companyName,
      premiumAmount,
      monthlyAmount,
      workshopCount,
    );
  }

  @override
  String toString() {
    return 'InsuranceModel(id: $id, companyName: $companyName, premiumAmount: $premiumAmount, monthlyAmount: $monthlyAmount, workshopCount: $workshopCount)';
  }
}
