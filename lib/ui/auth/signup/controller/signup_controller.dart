import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/ui/home/home_screen.dart';
import 'package:merchant/util/extensions.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../models/cities_list_model.dart' as model;
import '../../../../models/coutry_list_model.dart';
import '../../../../models/job_List_model.dart';
import '../../../../models/region_list_model.dart';
import '../../../../models/sign_up_error_model.dart';
import '../../../../services/localization_services.dart';
import '../../../../services/memory.dart';
import '../../../../services/translation_key.dart';
import '../../../../util/Constants.dart';
class SignupController extends GetxController {
  List<String> jobNames=[]; // List of job names to show in the dropdown
  List<Jobs>? jobList=[];
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController merchantNameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
SignupController( this.context);
  BuildContext context;
  @override
  Future<void> onInit() async {
    super.onInit();
    await CacheHelper.init();
    await GetJobsLists();
    checkLocationPermission().then((_) {
      getCurrentLocation(context);
    });
    await getCurrentLocation(context);

  }
  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Request permission
      await Permission.location.request();
    }
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
  final formKey = GlobalKey<FormState>();
  var pickedImage = File("");
  String? nameMerchant, type, summary, address, workingHours, paymentTypes;
  bool cash = false, visa = false, credit = false;

  String? email, name, mobile, job, password, confirmPassword;
  bool remember = false;
  final List<String?> errors = [];
   String? selectedJob;
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
  CustomTextFormField buildPaymentTypesField() {
    return CustomTextFormField(
        obscureText: true,
        hintText: paymentTypes?.tr??"",
        textInputAction: TextInputAction.done,
        onPressed: (newValue) => paymentTypes = newValue,
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kMerchantPaymentTypesNullError);
          }
        },
        onValidate: (value) {
          if (value!.isEmpty) {
            addError(error: kMerchantPaymentTypesNullError);
            return "";
          }
          return null;
        });
  }
  CustomTextFormField buildWorkingHoursField() {
    return CustomTextFormField(
      onPressed: (value) {
        workingHours = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantWorkingHoursNullError);
        }
        return null;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantWorkingHoursNullError);
          return "";
        }
        return null;
      },
      hintText: workingHours?.tr??"",
      textInputAction: TextInputAction.next,
    );
  }
  CustomTextFormField buildAddressField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: merchantAdrress.tr,
      onPressed: (value) {
        address = value;
      },
      onValidate: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        } else if (value.toString().isValidEmail()) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildNameMerchantField() {
    return CustomTextFormField(
      controller: merchantNameController,
      textInputType: TextInputType.text,
      hintText: merchantName.tr,
      onPressed: (value) {
        nameMerchant = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantNameNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantNameNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildTypeField() {
    return CustomTextFormField(
      controller:typeController,
      textInputType: TextInputType.text,
      hintText: merchantType.tr,
      suffixIcon: const Icon(Icons.arrow_drop_down),
      onPressed: (value) {
        type = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantTypeNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantTypeNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantTypeNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildSummaryField() {
    return CustomTextFormField(
      controller: summaryController,
      textInputType: TextInputType.text,
      hintText: merchantSummary.tr,
      onPressed: (value) {
        summary = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kMerchantSummaryNullError);
          return "";
        } else if (value.toString().isEmpty) {
          addError(error: kMerchantSummaryNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantSummaryNullError);
        }
        return null;
      },
    );
  }
  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
      controller: passwordController,
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      hintText: signUpConfirmPassword.tr,
      textInputAction: TextInputAction.done,
      suffixIcon: const Icon(Icons.visibility_off),
      onPressed: (newValue) => confirmPassword = newValue,
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
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: signUpEmail.tr,
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
      controller: nameController,
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
  CustomTextFormField buildStreetField() {
    return CustomTextFormField(
      controller: streetController,
        hintText: merchantStreet.tr,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }
  CustomTextFormField buildBuildingField() {
    return CustomTextFormField(
      controller: buildingController,
        hintText: merchantBuilding.tr,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }
  CustomTextFormField buildFlatField() {
    return CustomTextFormField(
      controller: apartmentController,
        hintText: merchantFlat.tr,
        textInputAction: TextInputAction.done,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }
  CustomTextFormField buildFloorField() {
    return CustomTextFormField(
      controller: floorController,
        hintText: merchantFloor.tr,
        textInputAction: TextInputAction.next,
        onPressed: () {},
        onChange: () {},
        onValidate: () {});
  }
  ListTile buildJobField(BuildContext context) {
    return  ListTile(
      title: Text(
        job ?? selectAJob.tr,
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
        textAlign: TextAlign.start,
      ),
      // Display the selected job or prompt to select
      trailing: Icon(Icons.arrow_drop_down),
      onTap: () async {
         selectedJob = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(200, 400, 200, 0), // Adjust position if needed
          items: jobNames.map((jobName) {
            return PopupMenuItem<String>(
              value: jobName,
              child: Text(jobName),
            );
          }).toList(),
        );
        if (selectedJob != null) {

            job = selectedJob; // Update selected job
         update();
          removeError(error: jobIsRequiredText.tr); // Remove error if job is selected
        }
      },
    );
  }
  void pickImage(BuildContext context) {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(content:  Text(chooseImageSource.tr), actions: [
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
  }
  Future<void> GetJobsLists() async {
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
        "/api/v1/jobs/search",
        data: {
          "search": {
            "langId":  Get.find<CacheHelper>()
                .activeLocale == SupportedLocales.english?2:1,
          },
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}", // Replace with your actual token
          },
        ),
      );
      if (response.statusCode == 200) {
        print("a");
        // Successful response
        JobListModel jobListModel = JobListModel.fromJson(response.data);
        jobList = jobListModel.data;
        print(jobList);// Save full job data if needed
        jobNames = jobList?.map((job) => job.jobName ?? '').toList() ?? [];
        print(jobNames);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed to load jobs')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
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
                        onTap: () {
                          selectedCity = city;
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
                        onTap: () {
                          selectedCountry = country;
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
  Future<void> signUp(BuildContext context) async {
    await Get.find<CacheHelper>().saveData(key: "mobileNo", value: mobileNumberController.text.trim());
    print(Get.find<CacheHelper>().getData(key: "year"));
    print(Get.find<CacheHelper>().getData(key: "companyCode"));
    print(emailController.text);
    print(passwordController.text);
    print(mobileNumberController.text);
    print(nameController.text);
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

    int? jobCode = jobList?.firstWhere((job) => job.jobName == selectedJob).id;
    print(jobCode);

    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/v1/vendors/merchantCreate",
        data: {
          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
          "branchCode": 2,
          "year": Get.find<CacheHelper>().getData(key: "year"),
          "vendorcode": "445588",
          "vendorNameEng": nameController.text.trim(),
          "vendorNameAra": nameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile1": mobileNumberController.text.trim(),
          "isMerchant": true,
          "jobCode": "$jobCode",  // ensure it's a string
          "password": passwordController.text.trim()
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      if (response.statusCode == 200) {
        print("ttttttttttttttttttttttttttt");
        int?code=response.data;
        DefaultTabController.of(context).animateTo(1);

      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        SignUpErrorModel responseModel = SignUpErrorModel.fromJson(response.data);

        // Use messages if available
        String errorMessage = "An error occurred, but no detailed message was provided.";

        // Check if messages are available and not empty
        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        }
        // Check if vendorCode errors are available and not empty
        else if (responseModel.errors?.vendorCode?.isNotEmpty == true) {
          errorMessage = responseModel.errors!.vendorCode!.join(", ");
        }

        print("Messages: ${responseModel.messages}");
        print("VendorCode Errors: ${responseModel.errors?.vendorCode}");

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("OK"),
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
            title: Text("Error"),
            content: Text("An unexpected error occurred: $e"),
            actions: [
              TextButton(
                child: Text("OK"),
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
  Future<void> createStore(BuildContext context) async {
    print("companyCode: ${Get.find<CacheHelper>().getData(key: "companyCode")}");
    print("descriptionAra: ${Get.find<CacheHelper>().getData(key: "merchantSummary")}");
    print("descriptionEng: ${Get.find<CacheHelper>().getData(key: "merchantName")}");
    print("companyNameAra: ${Get.find<CacheHelper>().getData(key: "merchantName")}");
    print("companyNameEng: ${Get.find<CacheHelper>().getData(key: "merchantName")}");
    print("mobile1: ${Get.find<CacheHelper>().getData(key: "mobileNo")}");
    print("address: ${locationController.text.trim()}");
    print("countryID: $countryCode");
    print("cityCode: $cityCode");
    print("zoneCode: $regionCode");
    print("street: ${streetController.text.trim()}");
    print("building: ${buildingController.text.trim()}");
    print("apartment: ${apartmentController.text.trim()}");
    print("floor: ${floorController.text.trim()}");
    print("latitude: $latitude");
    print("longitude: $longitude");
    print("addressOnMap: ${locationController.text.trim()}");

    final Dio dio = Dio(BaseOptions(
      baseUrl: Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/v1/companies",
        data: {
          "id": 0,
          "companyCode": Get.find<CacheHelper>().getData(key: "companyCode"),
          "descriptionAra": Get.find<CacheHelper>().getData(key: "merchantSummary"),
          "descriptionEng": Get.find<CacheHelper>().getData(key: "merchantName"),
          "companyNameAra": Get.find<CacheHelper>().getData(key: "merchantName"),
          "companyNameEng": Get.find<CacheHelper>().getData(key: "merchantName"),
          "companyTypeCode": "1",
          "mobile1": "${Get.find<CacheHelper>().getData(key: "mobileNo")}",
          "mobile2": "11",
          "address": locationController.text.trim(),
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
          "latitude": "$latitude",
          "longitude": "$longitude",
          "addressOnMap": locationController.text.trim(),
          // Add VendorCode here
          "storePaymentMethodList": [
            {
              "companyCode": 0,
              "paymentMethodCode": "1"
            }
          ],
          "storeWorkDayList": [
            {
              "companyCode": 0,
              "dayCode": 1,
              "fromTime": "16:55:10",
              "toTime": "16:55:10"
            }
          ]
        }
        ,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      if (response.statusCode == 200) {
        print("ttttttttttttttttttttttttttt");
        int?code=response.data;
        Get.offAllNamed(HomeScreen.routeName);
      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        SignUpErrorModel responseModel = SignUpErrorModel.fromJson(response.data);

        // Use messages if available
        String errorMessage = "An error occurred, but no detailed message was provided.";

        // Check if messages are available and not empty
        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        }
        // Check if vendorCode errors are available and not empty
        else if (responseModel.errors?.vendorCode?.isNotEmpty == true) {
          errorMessage = responseModel.errors!.vendorCode!.join(", ");
        }

        print("Messages: ${responseModel.messages}");
        print("VendorCode Errors: ${responseModel.errors?.vendorCode}");

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  child: Text("OK"),
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
            title: Text("Error"),
            content: Text("An unexpected error occurred: $e"),
            actions: [
              TextButton(
                child: Text("OK"),
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
  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Proceed with form submission
      print('Name: $name');
      print('Email: $email');
      print('Mobile: $mobile');
      print('Job: $job');
      print('Password: $password');
      print('Confirm Password: $confirmPassword');
    }
  }
}
