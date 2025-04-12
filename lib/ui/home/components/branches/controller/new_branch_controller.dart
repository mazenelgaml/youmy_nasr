
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/cities_list_model.dart' as model;
import '../../../../../models/coutry_list_model.dart';
import '../../../../../models/days_list_model.dart';
import '../../../../../models/payment_types_list_model.dart';
import '../../../../../models/region_list_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';


class NewBranchController extends GetxController {
// List of job names to show in the dropdown
  NewBranchController( this.context);
  BuildContext context;
  String? name, type, summary, address, workingHours, paymentTypes;
  bool daily = false;
  final List<String?> errors = [];
  final List<int> hoursList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
   List<DaysList>? daysName=[];
   List<String>selectDay=[];
  List<PaymentType>? paymentName=[];
  int fromHour = 1, toHour = 1;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  String? email, mobile, job, password, confirmPassword;
  bool remember = false;
  Future<void> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("يرجى تفعيل خدمة الموقع")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم رفض الإذن")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم رفض الإذن بشكل دائم")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Store latitude and longitude in variables
    latitude = position.latitude;
    longitude = position.longitude;

    // You can use these variables in another function now
    // Example: pass them to another function


    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    Placemark place = placemarks.first;

    locationController.text =
    "${place.street}, ${place.locality}, ${place.country}";
    update();
  }
  CustomTextFormField buildLocationOnMapField(BuildContext context) {
    return CustomTextFormField(
      controller: locationController,
      hintText: 'Location on map',
      suffixIcon: const Icon(Icons.location_on),
      readOnly: true,
      onPressed: () {
        getCurrentLocation(context);  // Correctly call the method here
      },
      onChange: (value) {},
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى تحديد الموقع';
        }
        return null;
      },
    );
  }
  bool _isPasswordVisible = false;
  bool _isObscure = true;
  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      onPressed: (value) {
        passwordController.text = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError); // Remove empty password error
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError); // Remove short password error
        }
        update(); // Ensure UI updates after change
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kPassNullError); // Add error if password is empty
          return "Password cannot be empty";
        }
        if (value.length < 8) {
          addError(error: kShortPassError); // Add error if password is too short
          return "Password must be at least 8 characters long";
        }
        return null;
      },
      hintText: signInTextPass.tr,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: _isObscure, // Correctly access the visibility state
      suffixIcon: IconButton(
        icon: Icon(
          _isObscure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: Colors.grey,
        ),
        onPressed: () {

          _isObscure = !_isObscure;
          update();
        },
      ),
    );
  }
  CustomTextFormField buildJobField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: job?.tr ?? "Job",
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onPressed: (value) {
        job = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kJobNullError);
          return "Job cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kJobNullError);
          return "Job cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kJobNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildNameField() {
    return CustomTextFormField(
      controller: merchantNameController,
      textInputType: TextInputType.text,
      hintText: signUpName.tr,
      onPressed: (value) {
        merchantNameController.text = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
    );
  }
  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kMobileNullError);
      return kMobileNullError;
    }
    removeError(error: kMobileNullError);
    return null;
  }
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kNameNullError);
      return kNameNullError;
    }
    removeError(error: kNameNullError);
    return null;
  }
  CustomTextFormField buildMobileField() {
    return CustomTextFormField(
      controller: mobileNumberController,
      textInputType: TextInputType.phone,
      hintText: mobileNO.tr,
      onPressed: (value) {
        mobile = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        }
        return null;
      },
    );
  }
  bool _isObscureC = true;
  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
      controller: confirmPasswordController,
      textInputType: TextInputType.visiblePassword,
      hintText: signUpConfirmPassword.tr,
      textInputAction: TextInputAction.done,
      obscureText: _isObscureC, // Correctly access the visibility state
      suffixIcon: IconButton(
        icon: Icon(
          _isObscureC ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: Colors.grey,
        ),
        onPressed: () {

          _isObscureC = !_isObscureC;
          update();
        },
      ),
      onPressed: (newValue) => confirmPassword = newValue,
      onChange: (value) {
        confirmPasswordController.text = value;

        // Remove errors if the field is not empty
        if (value.isNotEmpty) {
          removeError(error: kConfirmPassNullError);
        }

        // If the passwords match, remove the match error
        if (passwordController.text == value) {
          removeError(error: kMatchPassError);
        } else {
          addError(error: kMatchPassError); // Add mismatch error
        }
      },
      onValidate: (value) {
        // Handle empty input
        if (value == null || value.isEmpty) {
          addError(error: kConfirmPassNullError);
          return "Please confirm your password";
        }

        // Handle password mismatch
        if (passwordController.text != value) {
          addError(error: kMatchPassError);
          return "Passwords do not match";
        }

        // Remove errors if the passwords match
        removeError(error: kConfirmPassNullError);
        removeError(error: kMatchPassError);
        return null;
      },
    );
  }
  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType: TextInputType.emailAddress,
      hintText: signInTextEmail.tr,
      onPressed: (value) {
        email = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "Email cannot be empty";
        } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "Please enter a valid email address";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
    );
  }
  // Declare street variable
  String street = "";
// Constants for error messages
  String kStreetNullError = "Street cannot be empty";

  CustomTextFormField buildStreetField() {
    return CustomTextFormField(
      controller: streetController,
      hintText: merchantStreet.tr,
      onPressed: (value) {
        street = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kStreetNullError);
          return "Street cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kStreetNullError);
          return "Street cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kStreetNullError);
        }
        return null;
      },
    );
  }








  void addError({String? error}) {
    if (!errors.contains(error)) {

        errors.add(error);
        update();
    }
  }
  void removeError({String? error}) {
    if (errors.contains(error)) {

        errors.remove(error);
   update();
    }
  }
  List<String>? selectCity=[];
  List<String>? selectCountry=[];
  var selectedCity = merchantSelectCity.tr;
  var selectedCountry = merchantCountry.tr;
  int? dayCode;
  int? paymentCode;
  int? countryCode;
  int? cityCode;
  int? regionCode;
  double latitude=0;
  double longitude=0;
  List<model.cities>? citiesName=[];
  List<CountryData>? countriesName=[];
  List<String>? selectRegion=[];
  var selectedRegion = merchantSelectRegion.tr;
  List<Region>? RegionName=[];// Full job data if needed for future use
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController merchantNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController   timeToController = TextEditingController();
  TextEditingController   distanceToController = TextEditingController();
  TextEditingController   distanceFromController = TextEditingController();
  TextEditingController   distanceTCostController = TextEditingController();
  ListTile buildRegionField() {
    return ListTile(
      title: Text(selectedRegion ?? 'Select region'),
      trailing: Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostRegionLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Region'),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectRegion?.map((region) {
                      return ListTile(
                        leading: Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(region),
                        onTap: () {
                          selectedRegion = region;
                          Navigator.pop(context);
                          regionCode = RegionName?.firstWhere((region) => region.zoneName == selectedRegion).zoneCode;// Close the dialog
                          update(); // Update the UI
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> PostRegionLists() async {
    cityCode = citiesName?.firstWhere((city) => city.cityName == selectedCity).cityCode;

    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/api/v1/cityDetails/searchData",
        data: {

          "search": {
            "cityCode": cityCode,
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          }

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("aaaaaaaaaaaaaaa");
        // Successful response
        print(response.data,);
        RegionListModel regionListModel = RegionListModel.fromJson(response.data);
        RegionName = regionListModel.data;
        print(RegionName);// Save full job data if needed
        selectRegion = RegionName?.map((region) => region.zoneName ?? '').toList() ?? [];
        print(selectRegion);
        // Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load regions')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );

    }

    print(regionCode);
    update();

  }
  ListTile buildCityField() {
    return ListTile(
      title: Text(selectedCity ?? 'Select City'),
      trailing: Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostCityLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select City'),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCity?.map((city) {
                      return ListTile(
                        leading: Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(city),
                        onTap: () async{
                          selectedCity = city;
                          await PostRegionLists();
                          Navigator.pop(context); // Close the dialog
                          update(); // Update the UI
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  ListTile buildCountryField() {
    return ListTile(
      title: Text(selectedCountry ?? 'Select Country'),
      trailing: Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostCountryLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Country'),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCountry?.map((country) {
                      return ListTile(
                        leading: Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(country),
                        onTap: () async{
                          selectedCountry = country;
                          await PostCityLists();
                          Navigator.pop(context); // Close the dialog
                          update();
                          // Update the UI
                        },
                      );
                    }).toList() ?? [],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  Future<void> PostCityLists() async {
    countryCode = countriesName?.firstWhere((country) => country.countryName == selectedCountry).id;
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/api/v1/cityHeaders/searchData",
        data: {
          "search": {
            "countryID":countryCode,
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          }

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("aaaaaaaaaaaaaaa");
        // Successful response
        print(response.data,);
        model.CitiesListModel citiesListModel = model.CitiesListModel.fromJson(response.data);
        citiesName = citiesListModel.data;
        print(citiesName);// Save full job data if needed
        selectCity = citiesName?.map((city) => city.cityName ?? '').toList() ?? [];
        update();
        print(selectCity);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load cities')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  Future<void> PostCountryLists() async {
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/api/v1/countries/searchData",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          }

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("aaaaaaaaaaaaaaa");
        // Successful response
        print(response.data,);
        CountryListModel countriesListModel = CountryListModel.fromJson(response.data);
        countriesName = countriesListModel.data;
        print(countriesName);// Save full job data if needed
        selectCountry = countriesName?.map((city) => city.countryName ?? '').toList() ?? [];
        update();
        print(selectCountry);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load cities')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  Future<void> PostDaysLists() async {
    print("hello");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/api/v1/weekDays/searchData",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          }

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );
      if (response.statusCode == 200) {
        print("aaaaaaaaaaaaaaa");
        // Successful response
        print(response.data,);
        DaysListModel daysListModel = DaysListModel.fromJson(response.data);
        daysName = daysListModel.data;
 // Save full job data if needed
        selectDay = daysName?.map((day) => day.name ?? '').toList() ?? [];
        update();
        print(selectDay);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load days')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await getCurrentLocation(context);
   await PostCountryLists();
   await PostDaysLists();
   await PostPaymentLists();

    // Fetch job data when the controller initializes
  }
  CustomTextFormField buildBuildingField() {
    return CustomTextFormField(
        controller: buildingController,
        hintText: merchantBuilding.tr,
      onPressed: (value) {
        name = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },);
  }
  CustomTextFormField buildFlatField() {
    return CustomTextFormField(
        controller: apartmentController,
        hintText: merchantFlat.tr,
        textInputAction: TextInputAction.done,
      onPressed: (value) {
        name = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },);
  }
  CustomTextFormField buildFloorField() {
    return CustomTextFormField(
        controller: floorController,
        hintText: merchantFloor.tr,
        textInputAction: TextInputAction.next,
      onPressed: (value) {
        name = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },);
  }
  var selectPayment = <String>[].obs;
  var selectedPaymentMethods = <String, bool>{}.obs;
  List<String> selectedPayments=[];
  // Fetch payment methods from API
  Future<void> PostPaymentLists() async {
    print("Fetching Payment Methods...");
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    try {
      final response = await dio.post(
        "/api/v1/paymentMethods/searchData",
        data: {
          "search": {
            "LangId": Get.find<CacheHelper>().activeLocale == SupportedLocales.english ? 2 : 1,
          },
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: 'token')}",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("API Response: ${response.data}");
        PaymentTypeListModel paymentListModel = PaymentTypeListModel.fromJson(response.data);
        var paymentMethods = paymentListModel.data ?? [];
        paymentName=paymentListModel.data??[];
        selectPayment.value = paymentMethods.map((payment) => payment.paymentMethodName ?? '').toList();

        // Initialize selected states
        for (var payment in selectPayment) {
          selectedPaymentMethods[payment] = false; // Set all to false initially
        }
        update();
        print(selectPayment);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load payment methods')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }

  Future<void> postDeliveryFees() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    try {
      final response = await dio.post(
        "/api/v1/branchShipingCosts",
        data: {
          "companyCode": Get.find<CacheHelper>().getData(key: 'companyCode'),
          "branchCode": Get.find<CacheHelper>().getData(key: 'branchCode'),
          "fromDistance": distanceFromController.text.trim(),
          "toDistance": distanceToController.text.trim(),
          "shippingCost": int.parse(distanceTCostController.text.trim())

        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: 'token')}",
          },
        ),
      );

      if (response.statusCode == 200) {
        update();
        Navigator.pop(context);
        print("API Response: ${response.data}");



        update();

      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load payment methods')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }
  }

  // Toggle payment method state
  void togglePaymentMethod(String paymentMethod) {
    if (selectedPaymentMethods.containsKey(paymentMethod)) {
      selectedPaymentMethods[paymentMethod] = !selectedPaymentMethods[paymentMethod]!;
    } else {
      selectedPaymentMethods[paymentMethod] = true;
    }
    update();
  }

  Future<void> createBranch(BuildContext context) async {
    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      var companyCode = Get.find<CacheHelper>().getData(key: "companyCode");
      var name = Get.find<CacheHelper>().getData(key: "Name");
      var mobileNumber = Get.find<CacheHelper>().getData(key: "mobileNumber");
      var token = Get.find<CacheHelper>().getData(key: "token");

      List<WorkingHour> workingHours = getWorkingHours();
      if (workingHours == null || workingHours.isEmpty) {
        throw Exception("Working hours are not available.");
      }

      List<Map<String, dynamic>> storeWorkDayList = workingHours.map((workingHour) {
        String fromTime = "${workingHour.fromHour.toString().padLeft(2, '0')}:00:00";
        String toTime = "${workingHour.toHour.toString().padLeft(2, '0')}:00:00";
        return {
          "companyCode": companyCode,
          "dayCode": getDayCode(workingHour.title),
          "fromTime": fromTime,
          "toTime": toTime,
        };
      }).toList();

      List<Map<String, dynamic>> storePaymentMethodList = [];
      selectedPayments.forEach((paymentMethod) {
        var paymentInfo;
        if (paymentName != null) {
          paymentInfo = paymentName?.firstWhere(
                (payment) => payment.paymentMethodName == paymentMethod,
            orElse: () => PaymentType(paymentMethodName: "Default", paymentMethodCode: "0"),
          );

          if (paymentInfo != null && paymentInfo.paymentMethodCode != "0") {
            storePaymentMethodList.add({
              "companyCode": companyCode,
              "paymentMethodCode": "${paymentInfo.paymentMethodCode}",
            });
          } else {
            print("No matching payment method found for: $paymentMethod");
          }
        }
      });

      var requestBody = {
        "id": 0,
        "companyCode": companyCode,
        "descriptionAra": "uu",
        "descriptionEng": "uu",
        "companyNameAra": name,
        "companyNameEng": name,
        "companyTypeCode": "1",
        "mobile1": "$mobileNumber",
        "mobile2": "$mobileNumber",
        "address": "${locationController.text.trim()}",
        "tel1": "11",
        "tel2": "11",
        "fax1": "11",
        "countryID": countryCode,
        "cityCode": cityCode,
        "zoneCode": regionCode,
        "street": streetController.text.trim(),
        "building": buildingController.text.trim(),
        "apartment": apartmentController.text.trim(),
        "floor": floorController.text.trim(),
        "latitude": "${latitude}",
        "longitude": "${longitude}",
        "addressOnMap": "${locationController.text.trim()}",
        "storePaymentMethodList": storePaymentMethodList,
        "storeWorkDayList": storeWorkDayList,
      };

      print(requestBody);

      final response = await dio.post("/api/v1/companies",
          data: requestBody,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: 'token')}",
          },
        ), );

      if (response.statusCode == 200) {
        Get.back();
      } else {
        print('Failed to create branch');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while creating the branch: $e')),
      );
    }
  }

  int getDayCode(String day) {
    switch (day.toLowerCase()) {
      case "sunday":
        return 1;
      case "monday":
        return 2;
      case "tuesday":
        return 3;
      case "wednesday":
        return 4;
      case "thursday":
        return 5;
      case "friday":
        return 6;
      case "saturday":
        return 7;
      default:
        return 0; // Default or unknown day
    }
  }
  List<WorkingHour> getWorkingHours() {
    return [
      WorkingHour(title: "Monday", fromHour: 9, toHour: 17),
      WorkingHour(title: "Tuesday", fromHour: 9, toHour: 17),
      // Add other working hours as needed
    ];
  }
}
class WorkingHour {
  final String title;
  final int fromHour;
  final int toHour;

  WorkingHour({required this.title, required this.fromHour, required this.toHour});
}
