part of 'product_bloc.dart';

// @immutable
// sealed class ProductEvent {} // sealed class work only with Dart version 3.0 or later

abstract class ProductEvent {} // abstract class work with any Dart version.

class FetchProducts extends ProductEvent {}
