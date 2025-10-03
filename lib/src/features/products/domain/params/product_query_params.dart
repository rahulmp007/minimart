class ProductQueryParams {
  final int page;
  final int limit;
  final String? category;
  final String? minPrice;
  final String? maxPrice;
  final String? rating;
  final List<String>? tags;
  final String? sortBy;

  const ProductQueryParams({
    required this.page,
    required this.limit,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.tags,
    this.sortBy,
  });

  ProductQueryParams copyWith({
    int? page,
    int? limit,
    String? category,
    String? minPrice,
    String? maxPrice,
    String? rating,
    List<String>? tags,
    String? sortBy,
  }) {
    return ProductQueryParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  factory ProductQueryParams.initial() =>
      ProductQueryParams(page: 1, limit: 10);
}
