import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/ui/home/home_screen.dart';
import 'package:merchant/util/extensions.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../models/branches_login_model.dart';
import '../../../../models/cities_list_model.dart' as model;
import '../../../../models/company_types_list_model.dart';
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
  var selectedCompanyTypes = merchantType.tr;
  List<String>? selectCompanyTypes=[];
  List<CompanyType>? companyTypesName=[];
  String? companyTypesCode;
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
    await getBranches();
    await PostCompanyTypesLists();
    await PostCountryLists();

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
        const SnackBar(content: Text("يرجى تفعيل خدمة الموقع")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم رفض الإذن")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم رفض الإذن بشكل دائم")),
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
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  var pickedImage = File("");
  String? nameMerchant, type, summary, address, workingHours, paymentTypes;
  bool cash = false, visa = false, credit = false;
  String? floor;
  String? flat;
  String? building;
  String? street;
  String? email, name, mobile, job, password, confirmPassword;
  bool remember = false;
  final List<String?> errors = [];
   String? selectedJob;
  CustomTextFormField buildPaymentTypesField() {
    return CustomTextFormField(
      obscureText: true,
      hintText: paymentTypes?.tr ?? "",
      textInputAction: TextInputAction.done,
      onPressed: (newValue) => paymentTypes = newValue,
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantPaymentTypesNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kMerchantPaymentTypesNullError);
          return "";
        }
        return null;
      },
    );
  }
  CustomTextFormField buildWorkingHoursField() {
    return CustomTextFormField(
      hintText: workingHours?.tr ?? "",
      textInputAction: TextInputAction.next,
      onPressed: (value) {
        workingHours = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantWorkingHoursNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kMerchantWorkingHoursNullError);
          return "";
        }
        return null;
      },
    );
  }
  CustomTextFormField buildAddressField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: merchantAdrress.tr,
      onPressed: (value) {
        address = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
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
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantNameNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kMerchantNameNullError);
          return "";
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
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMerchantSummaryNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kMerchantSummaryNullError);
          return "";
        }
        return null;
      },
    );
  }
  bool _isPasswordVisible = false;
  bool _isObscure = true;
  bool _isObscureC = true;
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
  void removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      print("Removed error: $error");
      update(); // Notify listeners (if using a state management tool like GetX)
    }
  }
  void addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      print("Added error: $error");
      update(); // Notify listeners
    }
  }
  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      controller: emailController, // Ensure this is a TextEditingController
      textInputType: TextInputType.emailAddress,
      hintText: signUpEmail.tr, // Ensure this is a String
      onPressed: (value) {
        email = value; // Ensure `email` is a String.
      },
      onChange: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          removeError(error: kInvalidEmailError);
        } else if (!isValidEmail(value)) {
          addError(error: kInvalidEmailError);
          removeError(error: kEmailNullError);
        } else {
          removeError(error: kEmailNullError);
          removeError(error: kInvalidEmailError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          return kEmailNullError;
        } else if (!isValidEmail(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
    );
  }
  bool isValidEmail(String value) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(value);
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
  CustomTextFormField buildStreetField() {
    return CustomTextFormField(
      controller: streetController,
      hintText: merchantStreet.tr,
      onPressed: (value) {
        street = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kStreetNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kStreetNullError);
          return "";
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
        building = value;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kBuildingNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kBuildingNullError);
          return "";
        }
        return null;
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
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFlatNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kFlatNullError);
          return "";
        }
        return null;
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
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFloorNullError);
        }
      },
      onValidate: (value) {
        if (value == null || value.isEmpty) {
          addError(error: kFloorNullError);
          return "";
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
   String kFloorNullError = "Please enter the floor.";
   String kFlatNullError = "Please enter the flat.";
   String kBuildingNullError = "Please enter the building.";
   String kStreetNullError = "Please enter the street.";
  String? validatePaymentTypes(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kMerchantPaymentTypesNullError);
      return kMerchantPaymentTypesNullError;
    }
    removeError(error: kMerchantPaymentTypesNullError);
    return null;
  }
  String? validateWorkingHours(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kMerchantWorkingHoursNullError);
      return kMerchantWorkingHoursNullError;
    }
    removeError(error: kMerchantWorkingHoursNullError);
    return null;
  }
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kAddressNullError);
      return kAddressNullError;
    }
    removeError(error: kAddressNullError);
    return null;
  }
  String? validateMerchantName(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kMerchantNameNullError);
      return kMerchantNameNullError;
    }
    removeError(error: kMerchantNameNullError);
    return null;
  }
  String? validateSummary(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kMerchantSummaryNullError);
      return kMerchantSummaryNullError;
    }
    removeError(error: kMerchantSummaryNullError);
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kPassNullError);
      return kPassNullError;
    } else if (value.length < 8) {
      addError(error: kShortPassError);
      return kShortPassError;
    }
    removeError(error: kPassNullError);
    removeError(error: kShortPassError);
    return null;
  }
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kConfirmPassNullError);
      return kConfirmPassNullError;
    } else if (value != password) {
      addError(error: kMatchPassError);
      return kMatchPassError;
    }
    removeError(error: kConfirmPassNullError);
    removeError(error: kMatchPassError);
    return null;
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kEmailNullError);
      return kEmailNullError;
    } else if (!value.isValidEmail()) {
      addError(error: kInvalidEmailError);
      return kInvalidEmailError;
    }
    removeError(error: kEmailNullError);
    removeError(error: kInvalidEmailError);
    return null;
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
  String? validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kStreetNullError);
      return kStreetNullError;
    }
    removeError(error: kStreetNullError);
    return null;
  }
  String? validateBuilding(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kBuildingNullError);
      return kBuildingNullError;
    }
    removeError(error: kBuildingNullError);
    return null;
  }
  String? validateFlat(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kFlatNullError);
      return kFlatNullError;
    }
    removeError(error: kFlatNullError);
    return null;
  }
  String? validateFloor(String? value) {
    if (value == null || value.isEmpty) {
      addError(error: kFloorNullError);
      return kFloorNullError;
    }
    removeError(error: kFloorNullError);
    return null;
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
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () async {
         selectedJob = await showMenu<String>(
          context: context,
          position: const RelativeRect.fromLTRB(200, 400, 200, 0), // Adjust position if needed
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
  bool isLoading=true;
  List<String>? branchesLogin;
  List<BranchesLogin>? branchesList;
  String _selectedBranch = '';
  String get selectedBranch => _selectedBranch;
  set selectedBranch(String? value) {
    if (_selectedBranch != value) {
      _selectedBranch = value ?? '';
      update(); // Trigger UI update
    }
  }
  Future<void> getBranches() async {
    isLoading=true;
    print("ho");
    final Dio dio = Dio(BaseOptions(
      baseUrl:Get.find<CacheHelper>().getData(key: "Api"),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ));

    try {
      final response = await dio.post(
        "/api/v1/branches/loginsearch",
        data: {
          "search": {
            "companyCode":Get.find<CacheHelper>().getData(key: "companyCode"),
          }
        },
      );

      if (response.statusCode == 200) {
        BranchesLoginModel branchesLoginModel = BranchesLoginModel.fromJson(response.data);
        branchesList=branchesLoginModel.data;
        branchesLogin = branchesList?.map((branch) => Get.find<CacheHelper>()
            .activeLocale == SupportedLocales.english ?branch.branchNameEng ?? '':branch.branchNameAra??"").toList() ?? [];
        update();
        branchesLogin=branchesLogin?.toSet().toList();
        print(branchesList);
        print(branchesLogin);
        isLoading=false;
        update();
      }
    } catch (e) {
      print("Error: $e");
    }
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
          const SnackBar(content: Text('Failed to load jobs')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  ListTile buildCityField() {
    return ListTile(
      title: Text(selectedCity),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostCityLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text(Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english ?'Select City':"اختر المدينه"),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCity?.map((city) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
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
      title: Text(selectedCountry),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostCountryLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text(Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english ?'Select Country':"اختر البلد"),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCountry?.map((country) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
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
  ListTile buildCompanyTypesField() {

    return ListTile(
      title: Text(selectedCompanyTypes),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () {

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(merchantType.tr),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectCompanyTypes?.map((country) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
                        title: Text(country),
                        onTap: () {
                          selectedCompanyTypes = country;
                          companyTypesCode=companyTypesName?.firstWhere((companyType) => companyType.companyTypeName == selectedCompanyTypes).companyTypeCode;
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
  Future<void> PostCompanyTypesLists() async {
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
        "/api/v1/companyTypes/searchData",
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
        CompanyTypesListModel companyTypesListModel = CompanyTypesListModel.fromJson(response.data);
        companyTypesName = companyTypesListModel.data;
        print(companyTypesName);// Save full job data if needed
        selectCompanyTypes = companyTypesName?.map((companyType) => companyType.companyTypeName ?? '').toList() ?? [];
        update();
        print(selectCompanyTypes);
        update();// Extract only job names
      } else {
        // Error handling for failed response
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Failed to load company types')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
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
          const SnackBar(content: Text('Failed to load cities')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
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
          const SnackBar(content: Text('Failed to load cities')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );
    }update();
  }
  Future<void> signUp(BuildContext context) async {
    int? branchCode = branchesList
        ?.firstWhere((branch) =>
    branch.branchNameAra == selectedBranch ||
        branch.branchNameEng == selectedBranch)
        .branchCode;

    await Get.find<CacheHelper>().saveData(
        key: "mobileNo", value: mobileNumberController.text.trim());

    print(Get.find<CacheHelper>().getData(key: "year"));
    print(Get.find<CacheHelper>().getData(key: "companyCode"));
    print(emailController.text);
    print(passwordController.text);
    print(mobileNumberController.text);
    print(nameController.text);
    print(branchCode);

    int? jobCode = jobList?.firstWhere((job) => job.jobName == selectedJob).id;
    print(jobCode);

    // Get and increment vendorCode
    int vendorCode = Get.find<CacheHelper>().getData(key: "vendorCode") ?? 25; // Default to 1 if null
    print("Current VendorCode: $vendorCode");

    // Increment the vendorCode and save it back
    vendorCode++;
    await Get.find<CacheHelper>().saveData(key: "vendorCode", value: vendorCode);

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
          "branchCode": branchCode,
          "year": Get.find<CacheHelper>().getData(key: "year"),
          "vendorcode": "$vendorCode", // Use the incremented vendorCode
          "vendorNameEng": nameController.text.trim(),
          "vendorNameAra": nameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile1": mobileNumberController.text.trim(),
          "isMerchant": true,
          "jobCode": "$jobCode", // Ensure it's a string
          "password": passwordController.text.trim()
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":
            "Bearer ${Get.find<CacheHelper>().getData(key: "token")}"
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Vendor successfully created!");
        DefaultTabController.of(context).animateTo(1);
      } else {
        // Log the entire response for debugging
        print("Response Data: ${response.data}");

        // Handle error model
        SignUpErrorModel responseModel =
        SignUpErrorModel.fromJson(response.data);

        String errorMessage =
            "An error occurred, but no detailed message was provided.";

        if (responseModel.messages?.isNotEmpty == true) {
          errorMessage = responseModel.messages!.join(", ");
        } else if (responseModel.errors?.vendorCode?.isNotEmpty == true) {
          errorMessage = responseModel.errors!.vendorCode!.join(", ");
        }

        print("Messages: ${responseModel.messages}");
        print("VendorCode Errors: ${responseModel.errors?.vendorCode}");

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
          "companyTypeCode": companyTypesCode,
          "mobile1": "${Get.find<CacheHelper>().getData(key: "mobileNo")}",
          "mobile2":"${Get.find<CacheHelper>().getData(key: "mobileNo")}",
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
  ListTile buildRegionField() {
    return ListTile(
      title: Text(selectedRegion),
      trailing: const Icon(Icons.arrow_drop_down,size: 40,),
      onTap: () async {
        await PostRegionLists();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text(Get.find<CacheHelper>()
                  .activeLocale == SupportedLocales.english ?'Select Region':"اختر المنطقه"),
              content: SingleChildScrollView(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  minLeadingWidth: 40.0, // Set minimum leading width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: selectRegion?.map((region) {
                      return ListTile(
                        leading: const Icon(Icons.location_on, size: 24.0), // Adjust icon size
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
          const SnackBar(content: Text('Failed to load regions')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Error occurred while connecting to the API')),
      );

    }

    print(regionCode);
    update();

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
        "/api/v1/branchAttachments",
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
