import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/store_service.dart';

final storeServiceProvider=Provider<StoreService>((ref) => StoreService(ref));