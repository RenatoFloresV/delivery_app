part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;

  const CategoriesLoaded([this.categories = const []]);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'Categories loaded';
}

class CategoriesNoLoaded extends CategoriesState {}

class CategoriesError extends CategoriesState {
  final String error;

  const CategoriesError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CategoriesError { error: $error }';
}
