import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/providers/api_provider/rent_provider.dart';
import 'package:p_cube_plus_application/providers/api_provider/schedule_provider.dart';

class HomeProvider extends CompositeProviderBase {
  HomeProvider(ScheduleProvider scheduleProvider, RentProvider rentProvider)
      : super(providerMap: {
          #ScheduleProvider: scheduleProvider,
          #RentProvider: rentProvider,
        });
}
