/// Comprehensive insurance model containing all product details.
/// 
/// This model represents a complete insurance product with all necessary
/// information for display and navigation between pages.
class InsuranceModel {
  /// Unique identifier for the insurance product
  final String id;
  
  /// Company name (e.g., "Askari Health Insurance")
  final String companyName;
  
  /// Premium amount (e.g., "2,500")
  final String premiumAmount;
  
  /// Monthly payment amount (e.g., "208")
  final String monthlyAmount;
  
  /// Number of workshops (e.g., "500+")
  final String workshopCount;
  
  /// Company logo/icon data (optional)
  final String? logoPath;
  
  /// Product description (optional)
  final String? description;
  
  /// Product category (e.g., "Health", "Car", "Family")
  final String? category;
  
  /// Additional product features (optional)
  final List<String>? features;

  /// Creates an insurance model with all required parameters
  const InsuranceModel({
    required this.id,
    required this.companyName,
    required this.premiumAmount,
    required this.monthlyAmount,
    required this.workshopCount,
    this.logoPath,
    this.description,
    this.category,
    this.features,
  });

  /// Creates an InsuranceModel from a JSON map
  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    try {
      return InsuranceModel(
        id: json['id']?.toString() ?? '',
        companyName: json['companyName']?.toString() ?? '',
        premiumAmount: json['premiumAmount']?.toString() ?? '',
        monthlyAmount: json['monthlyAmount']?.toString() ?? '',
        workshopCount: json['workshopCount']?.toString() ?? '',
        logoPath: json['logoPath']?.toString(),
        description: json['description']?.toString(),
        category: json['category']?.toString(),
        features: json['features'] != null 
            ? List<String>.from(json['features'] as List)
            : null,
      );
    } catch (e) {
      throw Exception('Error parsing InsuranceModel: $e');
    }
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    try {
      return {
        'id': id,
        'companyName': companyName,
        'premiumAmount': premiumAmount,
        'monthlyAmount': monthlyAmount,
        'workshopCount': workshopCount,
        'logoPath': logoPath,
        'description': description,
        'category': category,
        'features': features,
      };
    } catch (e) {
      throw Exception('Error converting InsuranceModel to JSON: $e');
    }
  }

  /// Creates a copy of this model with updated values
  InsuranceModel copyWith({
    String? id,
    String? companyName,
    String? premiumAmount,
    String? monthlyAmount,
    String? workshopCount,
    String? logoPath,
    String? description,
    String? category,
    List<String>? features,
  }) {
    return InsuranceModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      premiumAmount: premiumAmount ?? this.premiumAmount,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
      workshopCount: workshopCount ?? this.workshopCount,
      logoPath: logoPath ?? this.logoPath,
      description: description ?? this.description,
      category: category ?? this.category,
      features: features ?? this.features,
    );
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
