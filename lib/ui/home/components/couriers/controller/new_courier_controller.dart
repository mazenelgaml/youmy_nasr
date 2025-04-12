import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/models/create_courier_error_model.dart';
import 'package:merchant/ui/home/components/couriers/controller/couriers_controller.dart';
import 'package:merchant/ui/home/components/couriers/courier_screen.dart';
import 'package:merchant/util/extensions.dart';
import 'package:path/path.dart';
import '../../../../../components/custom_text.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../models/cities_list_model.dart' as model;
import '../../../../../models/coutry_list_model.dart';
import '../../../../../models/region_list_model.dart';
import '../../../../../services/localization_services.dart';
import '../../../../../services/memory.dart';
import '../../../../../services/translation_key.dart';
import '../../../../../util/Constants.dart';
class NewCourierController extends GetxController {
  NewCourierController( this.context);
  BuildContext context;
  String? name, type, summary, address, workingHours, paymentTypes;
  bool daily = false;
  final List<String?> errors = [];
  final formKey = GlobalKey<FormState>();
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
  bool _isPasswordVisible = false;
  CustomTextFormField buildPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      onPressed: (value) {
        password = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kPassNullError);
          return "Password cannot be empty";
        }
        if (value.length < 8) {
          addError(error: kShortPassError);
          return "Password must be at least 8 characters long";
        }
        return null;
      },
      hintText: signInTextPass.tr,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: !_isPasswordVisible, // Toggles password visibility
      suffixList: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {

          _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
          update();
        },
      ),
    );
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
   String kEmailNullError = "Please enter your email";
   String kInvalidEmailError = "Please enter a valid email";
   String kMobileNullError = "Please enter your mobile number";
   String kBuildingNullError = "Please enter your building";
   String kFlatNullError = "Please enter your flat";
   String kFloorNullError = "Please enter your floor";
   String kStreetNullError = "Please enter your street";
   String kNameNullError = "Please enter a name";
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController courierNameAraController = TextEditingController();
  TextEditingController courierNameEngController = TextEditingController();
  String building = "";
  String flat = "";
  String floor = "";
  String street = "";
  String nameAR = "";
  String nameEN = "";
  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: signInTextEmail.tr,
      onPressed: (value) {
        email = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "Email cannot be empty";
        } else if (!value.toString().isValidEmail()) {
          addError(error: kInvalidEmailError);
          return "Invalid email format";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kInvalidEmailError);
        }
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
          return "Mobile number cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kMobileNullError);
          return "Mobile number cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMobileNullError);
        }
      },
    );
  }
  CustomTextFormField buildBuildingField() {
    return CustomTextFormField(
      controller: buildingController,
      hintText: merchantBuilding.tr,
      onPressed: (value) {
        building = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kBuildingNullError);
          return "Building cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kBuildingNullError);
          return "Building cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kBuildingNullError);
        }
      },
    );
  }
  CustomTextFormField buildFlatField() {
    return CustomTextFormField(
      controller: apartmentController,
      hintText: merchantFlat.tr,
      textInputAction: TextInputAction.done,
      onPressed: (value) {
        flat = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kFlatNullError);
          return "Flat cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kFlatNullError);
          return "Flat cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFlatNullError);
        }
      },
    );
  }
  CustomTextFormField buildFloorField() {
    return CustomTextFormField(
      controller: floorController,
      hintText: merchantFloor.tr,
      textInputAction: TextInputAction.next,
      onPressed: (value) {
        floor = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kFloorNullError);
          return "Floor cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kFloorNullError);
          return "Floor cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFloorNullError);
        }
      },
    );
  }
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
      },
    );
  }
  CustomTextFormField buildNameARField() {
    return CustomTextFormField(
      controller: courierNameAraController,
      textInputType: TextInputType.text,
      hintText: newCourierNameArabic.tr,
      onPressed: (value) {
        nameAR = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "Arabic Name cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kNameNullError);
          return "Arabic Name cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
      },
    );
  }
  CustomTextFormField buildNameENField() {
    return CustomTextFormField(
      controller: courierNameEngController,
      textInputType: TextInputType.text,
      hintText: newCourierNameEnglish.tr,
      onPressed: (value) {
        nameEN = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "English Name cannot be empty";
        } else if (value.toString().isEmpty) {
          addError(error: kNameNullError);
          return "English Name cannot be empty";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
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
  int? countryCode;
  int? cityCode;
  int? regionCode;
  double latitude=0;
  double longitude=0;
  List<model.cities>? citiesName=[];
  List<CountryData>? countriesName=[];
  List<String>? selectRegion=[];
  var selectedRegion = merchantSelectRegion.tr;
  List<Region>? RegionName=[];
  Widget buildBirthDateField(String hintText) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        CustomTextFormField(
          readOnly: true,
          suffixIcon: const Icon(Icons.calendar_today),
          textInputType: TextInputType.text,
          hintText: hintText,
          onPressed: () {},
          onValidate: (value) {
            if (value!.isEmpty) {
              addError(error: kNameNullError);
              return "";
            } else if (value
                .toString()
                .isEmpty) {
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
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xfff96800)),
          onPressed: () async {
            final datePick = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (datePick != null && datePick != birthDate) {

                birthDate = datePick;
                // isDateSelected=true;
                print('MAIN- $birthDateInString');
                // put it here
                birthDateInString =
                "${birthDate?.month}/${birthDate?.day}/${birthDate
                    ?.year}"; // 08/14/2019
             update();
            }

            // Your codes...
          },
        ),
      ],
    );
  }
  var pickedImage = File("");
  String birthDateInString = newCourierBirtDate.tr;
  DateTime? birthDate;
  var selectedType;
  final List<String> vehicleTypes = [
    selectVehicleF.tr, // Ensure translations are unique
    carF.tr,
    motorBikeF.tr,
    bikeF.tr,
    otherF.tr
  ];
  DropdownButton<String> buildVehicleTypeField() {

    return DropdownButton<String>(
      hint: CustomText(
        text: newCourierSelectVehicle.tr,
      ),
      iconSize: 40,
      isExpanded: true,
      value: vehicleTypes.contains(selectedType) ? selectedType : null,
      items: vehicleTypes.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {

          selectedType = value;
       update();
      },
    );
  }
  void pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content:  Text(chooseImageSource.tr), actions: [
            MaterialButton(
              child:  Text(camera.tr),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            MaterialButton(
              child:  Text(gallery.tr),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        print('SOURCE ${pickedFile!.path}');


          pickedImage = File(pickedFile.path);
          print('_pickedImage ${pickedImage}');
       update();
      }
    });
  }
  ImageProvider getImage(File file) {
    if (file.path.isEmpty) {
      return const AssetImage("assets/images/profile.png");
    } else {
      return FileImage(file);
    }
  }// Full job data if needed for future use
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
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
      title: Text(selectedCity),
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
      title: Text(selectedCountry),
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
    selectedType = vehicleTypes.first;
  }
  Future<void> createCourier(BuildContext context) async {
    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      // validateStatus: (status) {
      //   return status != null && status <= 500;
      // },
    ));

    // Prepare the data to send in the request
    final requestData = {
      "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
      "branchCode": Get.find<CacheHelper>().getData(key: "branchCode"),
      "salesManCode": "0",
      "salesManNameAra": "${Get.find<CacheHelper>().getData(key: "courierNameAra")}",
      "salesManNameEng": "${Get.find<CacheHelper>().getData(key: "courierNameEng")}",
      "email": "${Get.find<CacheHelper>().getData(key: "courierEmail")}",
      "password": "${Get.find<CacheHelper>().getData(key: "courierPassword")}",
      "mobileNo": "${Get.find<CacheHelper>().getData(key: "courierPhoneNo")}",
      "address": "${locationController.text.trim()}",
    };

    // Print the request body data
    print("Request Body Data: $requestData");

    try {
      final response = await dio.post(
        "/api/v1/salesMans",
        data: requestData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response Code: ${response.data}");
        Get.delete<CouriersController>();
        Get.to(CourierScreen());
        Get.put(CouriersController());
      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        CreateCourierErrorModel responseModel = CreateCourierErrorModel.fromJson(response.data);

        // Use messages if available
        String errorMessage = "An error occurred, but no detailed message was provided.";
        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        }

        print("Messages: ${responseModel.messages}");

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Catch and log unexpected errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("An unexpected error occurred: $e"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
      print("Error: $e");
    }
  }
  TextEditingController descController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Map<String, dynamic>? selectedFileData;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String fileBase64 = base64Encode(file.readAsBytesSync());
      String filePath = file.path;
      String fileName = basename(filePath);
      String fileExtension = extension(filePath).replaceFirst('.', '');
      int fileSize = await file.length();

      selectedFileData = {
        "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
        "fileFullName": fileName,
        "fileName": fileName,
        "fileExtension": fileExtension,
        "filePath": filePath,
        "fileBase64": fileBase64,
        "originalPath": filePath,
        "fileSize": fileSize.toString()
        // description هيتحط وقت الرفع
      };

      Get.snackbar("تم اختيار الملف", fileName);
    } else {
      print('لم يتم اختيار أي ملف');
    }
  }
  Future<void> uploadSelectedFile(String description) async {
    print("hellooooooooooooo1");

    if (selectedFileData == null) {
      Get.snackbar("خطأ", "من فضلك اختر ملف أولاً");
      return;
    }

    print("hellooooooooooooo2");

    // إضافة الوصف إلى الداتا قبل الإرسال
    selectedFileData!["description"] = description;

    // طباعة البيانات للتأكد منها
    print("Data to send: ${selectedFileData}");

    print("hellooooooooooooo3");

    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) => status != null && status <= 500,
    ));

    try {
      print("hellooooooooooooo4");

      final response = await dio.post(
        "/api/v1/vendorsAttachments",
        data: selectedFileData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      // طباعة الاستجابة
      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // إغلاق الـ BottomSheet باستخدام Get.back()
        Get.snackbar("نجاح", "تم رفع الملف بنجاح");
        update();
        Navigator.pop(context); // Close the BottomSheet
      } else {
        print("Response Data: ${response.data}");
        Get.snackbar("فشل", "حدث خطأ أثناء رفع الملف: ${response.data}");
      }
    } catch (e) {
      // طباعة الخطأ بالكامل
      print("Error: $e");
      Get.defaultDialog(
        title: "خطأ",
        middleText: "حدث خطأ أثناء رفع الملف: $e",
      );
    }
  }
}
