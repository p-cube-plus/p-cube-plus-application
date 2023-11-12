import '../base/provider_base.dart';
import '../rent_provider.dart';
import '../schedule_provider.dart';

class HomeProvider extends CompositeProviderBase {
  HomeProvider(ScheduleProvider scheduleProvider, RentProvider rentProvider)
      : super(providerList: [
          scheduleProvider,
          rentProvider,
        ]);
}
