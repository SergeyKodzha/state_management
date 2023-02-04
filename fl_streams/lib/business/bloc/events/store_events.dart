import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {}

class StoreFetchData extends StoreEvent {
  @override
  List<Object?> get props => [];
}
