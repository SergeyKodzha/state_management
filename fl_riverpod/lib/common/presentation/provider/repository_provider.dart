import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/mock_auth_repository.dart';
import '../../../data/repository/mock_local_repository.dart';
import '../../../data/repository/mock_remote_repository.dart';

final authRepoProvider=Provider((ref) => MockAuthRepository());
final localRepoProvider=Provider((ref) => MockLocalRepository());
final remoteRepoProvider=Provider((ref) => MockRemoteRepository());
