import 'package:dartin/dartin.dart';
import 'package:dio/dio.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/viewmodel/advert_provider.dart';
import 'package:glassapp/viewmodel/agreement_provider.dart';
import 'package:glassapp/viewmodel/app_themes.dart';
import 'package:glassapp/viewmodel/bind_person_provider.dart';
import 'package:glassapp/viewmodel/bottom_sheet_provider.dart';
import 'package:glassapp/viewmodel/company_info_provider.dart';
import 'package:glassapp/viewmodel/contact_provider.dart';
import 'package:glassapp/viewmodel/feature_menu_provider.dart';
import 'package:glassapp/viewmodel/goods_category_provider.dart';
import 'package:glassapp/viewmodel/goods_details_provider.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
import 'package:glassapp/viewmodel/order_list_provider.dart';
import 'package:glassapp/viewmodel/room_provider.dart';
import 'package:glassapp/viewmodel/scan_bluetooth_provider.dart';
import 'package:glassapp/viewmodel/scan_wifi_provider.dart';
import 'package:glassapp/viewmodel/self_info_provider.dart';
import 'package:glassapp/viewmodel/settings_provider.dart';
import 'package:glassapp/viewmodel/shop_cart_provider.dart';
import 'package:glassapp/viewmodel/shop_home_provider.dart';
import 'package:glassapp/viewmodel/shop_mine_provider.dart';
import 'package:glassapp/viewmodel/shop_recommend_provider.dart';

SpCaller caller;
HomeProvider homeProvider;

init() async {
  caller = await SpCaller.getInstance();
  startDartIn(appModule);
}

final dio = Dio();

final localModule = Module([
  single<SpCaller>(({params}) => caller),
  single<AppThemes>(({params}) => AppThemes())
]);


final appModule = [viewModelModule, localModule];

final viewModelModule = Module([
  factory<SettingsProvider>(
      ({params}) => SettingsProvider(params.get(0), get(),get())),
  factory<SelfInfoProvider>(({params}) => SelfInfoProvider(get())),
  factory<FeatureMenuProvider>(({params}) => FeatureMenuProvider()),
  factory<ContactProvider>(({params}) => ContactProvider(get())),
  single<ScanBluetoothProvider>(({params}) => ScanBluetoothProvider(get())),
  factory<ScanWifiProvider>(({params}) => ScanWifiProvider(get(), get())),
  single<HomeProvider>(
      ({params}) => (homeProvider = HomeProvider(get(), get()))),
  factory<RoomProvider>(({params}) => RoomProvider(get())),
  factory<AdvertProvider>(({params}) => AdvertProvider(get())),
  factory<AgreementProvider>(({params}) => AgreementProvider()),
  factory<ShopHomeProvider>(({params}) => ShopHomeProvider(get())),
  factory<CompanyInfoProvider>(({params}) => CompanyInfoProvider()),
  factory<GoodsDetailsProvider>(({params}) => GoodsDetailsProvider(get())),
  factory<ShopRecommendProvider>(({params}) => ShopRecommendProvider(get())),
  factory<GoodsCategoryProvider>(({params}) => GoodsCategoryProvider(get())),
  factory<OrderListProvider>(({params}) => OrderListProvider(get())),
  factory<ShopMineProvider>(({params}) => ShopMineProvider(get())),
  factory<GoodsPropertiesBottomSheetProvider>(({params}) => GoodsPropertiesBottomSheetProvider(get())),
  factory<BindPersonProvider>(({params}) => BindPersonProvider(get())),
  factory<ShopCartProvider>(({params}) => ShopCartProvider(get())),
//  factory<BookProvider>(({params}) => BookProvider(get())),
]);
