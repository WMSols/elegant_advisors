/// Base model class for all domain models
abstract class BaseModel {
  BaseModel();

  /// Convert model to JSON
  Map<String, dynamic> toJson();

  /// Create model from JSON
  BaseModel fromJson(Map<String, dynamic> json);
}

