import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/dishes_service.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RecipeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<LocationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ConversationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ChefService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DishesService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserdataServiceService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PinDropService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterRecipeService();
  getAndRegisterLocationService();
  getAndRegisterConversationService();
  getAndRegisterChefService();
  getAndRegisterDishesService();
  getAndRegisterUserdataServiceService();
  getAndRegisterPinDropService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockRecipeService getAndRegisterRecipeService() {
  _removeRegistrationIfExists<RecipeService>();
  final service = MockRecipeService();
  locator.registerSingleton<RecipeService>(service);
  return service;
}

MockLocationService getAndRegisterLocationService() {
  _removeRegistrationIfExists<LocationService>();
  final service = MockLocationService();
  locator.registerSingleton<LocationService>(service);
  return service;
}

MockConversationService getAndRegisterConversationService() {
  _removeRegistrationIfExists<ConversationService>();
  final service = MockConversationService();
  locator.registerSingleton<ConversationService>(service);
  return service;
}

MockChefService getAndRegisterChefService() {
  _removeRegistrationIfExists<ChefService>();
  final service = MockChefService();
  locator.registerSingleton<ChefService>(service);
  return service;
}

MockDishesService getAndRegisterDishesService() {
  _removeRegistrationIfExists<DishesService>();
  final service = MockDishesService();
  locator.registerSingleton<DishesService>(service);
  return service;
}

MockUserdataServiceService getAndRegisterUserdataServiceService() {
  _removeRegistrationIfExists<UserdataServiceService>();
  final service = MockUserdataServiceService();
  locator.registerSingleton<UserdataServiceService>(service);
  return service;
}

MockPinDropService getAndRegisterPinDropService() {
  _removeRegistrationIfExists<PinDropService>();
  final service = MockPinDropService();
  locator.registerSingleton<PinDropService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
