import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/di/injection.config.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/features/sync/data/sync_di_module.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  await SyncDiModule.configure(getIt);
  getIt.registerSingleton<NotificationService>(NotificationService());
}
