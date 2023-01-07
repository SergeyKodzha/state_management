import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/app_service.dart';
import '../events/store_events.dart';
import '../states/store_state.dart';

class StoreBloc extends Bloc<StoreEvent,StoreState>{
  final AppService _service;
  StoreBloc(this._service):super(StoreState.initial()){
    on<StoreFetchData>(_onFetch);
  }


  void _onFetch(StoreFetchData event, Emitter<StoreState> emit) async {
    emit(state.copyWith(status:StoreStatus.loading));
    final products=await _service.fetchAllProducts();
    print('got products');
    emit(state.copyWith(status:StoreStatus.idle,products: products));
  }
}