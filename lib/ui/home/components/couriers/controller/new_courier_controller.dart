import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:merchant/util/extensions.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/cities_list_model.dart' as model;
import '../../../../../models/coutry_list_model.dart';
import '../../../../../models/region_list_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';


class NewCourierController extends GetxController {
// List of job names to show in the dropdown
  NewCourierController( this.context);
  BuildContext context;
  String? name, type, summary, address, workingHours, paymentTypes;
  bool daily = false;
  final List<String?> errors = [];

  final formKey = GlobalKey<FormState>();
  String? email, mobile, job, password, confirmPassword;
  bool remember = false;
  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
        controller: confirmPasswordController,
        obscureText: true,
        textInputType: TextInputType.visiblePassword,
        hintText: signUpConfirmPassword.tr,
        textInputAction: TextInputAction.done,
        suffixIcon: const Icon(Icons.visibility_off),
        onPressed: (newValue) =>  confirmPassword = newValue,
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kConfirmPassNullError);
          } else if (value.isNotEmpty && password == confirmPassword) {
            removeError(error: kMatchPassError);
          }
          confirmPassword = value;
        },
        onValidate: (value) {
          if (value!.isEmpty) {
            addError(error: kConfirmPassNullError);
            return "";
          } else if ((password != value)) {
            addError(error: kMatchPassError);
            return "";
          }
          return null;
        });
  }
  CustomTextFormField buildStreetField() {
    return CustomTextFormField(
      controller: streetController,
      hintText: merchantStreet.tr,
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
  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      onPressed: (value) {
        password = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      hintText: signUpPassword.tr,
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
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
          return "";
        } else if (!value.toString().isValidEmail()) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kInvalidEmailError);
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
      },
    );
  }
  CustomTextFormField buildMobileField() {
    return CustomTextFormField(
      controller: mobileNumberController,
      textInputType: TextInputType.phone,
      hintText: mobileNO.tr,
      onPressed: (value) {
        mobile = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMobileNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMobileNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        }
        return null;
      },
    );
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
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await getCurrentLocation(context);
    await PostCountryLists();


    // Fetch job data when the controller initializes
  }

}
