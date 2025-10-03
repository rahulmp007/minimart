import 'package:minimart/src/features/products/data/models/product_model.dart';
import 'package:minimart/src/features/products/data/models/review_model.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';
import 'package:minimart/src/features/products/domain/entity/review.dart';

class ProductMapper {
  static Product toEntity({required ProductModel model}) => Product(
    id: model.id,
    title: model.title,
    description: model.description,
    category: model.category,
    price: model.price,
    discountPercentage: model.discountPercentage,
    rating: model.rating,
    stock: model.stock,
    tags: model.tags,
    brand: model.brand,
    sku: model.sku,
    warrantyInformation: model.warrantyInformation,
    shippingInformation: model.shippingInformation,
    availabilityStatus: model.availabilityStatus,
    reviews:
        model.reviews?.map((model) => toReviewEntity(model: model)).toList() ??
        [],
    returnPolicy: model.returnPolicy,
    minimumOrderQuantity: model.minimumOrderQuantity,
    images: model.images,
    thumbnail: model.thumbnail,
  );

  static ProductModel toModel({required Product entity}) => ProductModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    category: entity.category,
    price: entity.price,
    discountPercentage: entity.discountPercentage,
    rating: entity.rating,
    stock: entity.stock,
    tags: entity.tags,
    brand: entity.brand,
    sku: entity.sku,
    warrantyInformation: entity.warrantyInformation,
    shippingInformation: entity.shippingInformation,
    availabilityStatus: entity.availabilityStatus,
    reviews:
        entity.reviews
            ?.map((reviewEntity) => toReviewModel(entity: reviewEntity))
            .toList() ??
        [],
    returnPolicy: entity.returnPolicy,
    minimumOrderQuantity: entity.minimumOrderQuantity,
    images: entity.images,
    thumbnail: entity.thumbnail,
  );

  static Review toReviewEntity({required ReviewModel model}) {
    return Review(
      rating: model.rating,
      comment: model.comment,
      date: model.date,
      reviewerName: model.reviewerName,
      reviewerEmail: model.reviewerEmail,
    );
  }

  static ReviewModel toReviewModel({required Review entity}) {
    return ReviewModel(
      rating: entity.rating,
      comment: entity.comment,
      date: entity.date,
      reviewerName: entity.reviewerName,
      reviewerEmail: entity.reviewerEmail,
    );
  }
}
