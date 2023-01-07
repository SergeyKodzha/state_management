
import '../../../common/custom_bloc/custom_bloc.dart';
import '../../application/app_service.dart';
import '../events/store_events.dart';
import '../states/store_state.dart';

class StoreBloc extends CustomBloc<StoreEvent,StoreState>{
  final AppService _service;
  StoreBloc(this._service):super(StoreState.initial());

  @override
  void handleEvent(StoreEvent event) {
    if (event is StoreFetchData){
      _onFetch(event);
    }
  }

  void _onFetch(StoreFetchData event) async {
    emit(state.copyWith(status:StoreStatus.loading));
    final products=await _service.fetchAllProducts();
    emit(state.copyWith(status:StoreStatus.idle,products: products));
  }
}