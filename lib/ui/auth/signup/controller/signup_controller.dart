import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/util/extensions.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../components/custom_text_form_field.dart';
import '../../../../models/error_model.dart';
import '../../../../models/job_List_model.dart';
import '../../../../models/login_model.dart';
import '../../../../services/memory.dart';
import '../../../../util/Constants.dart';
import '../../../home/home_screen.dart';

class SignupController extends GetxController {
  List<String> jobNames=[]; // List of job names to show in the dropdown
  List<Jobs>? selectJob=[]; // Full job data if needed for future use
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
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
    await getCurrentLocation(context);// Fetch job data when the controller initializes
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

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
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
  String? email, name, mobile, job, password, confirmPassword;
  bool remember = false;
  final List<String?> errors = [];

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

  CustomTextFormField buildConfirmPasswordField() {
    return CustomTextFormField(
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      hintText: 'Confirm Password',
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
      hintText: 'Password',
      textInputType: TextInputType.visiblePassword,
      suffixIcon: const Icon(Icons.visibility_off),
    );
  }

  CustomTextFormField buildEmailField() {
    return CustomTextFormField(
      textInputType: TextInputType.emailAddress,
      hintText: 'Email',
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
      textInputType: TextInputType.text,
      hintText: 'Name',
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
      textInputType: TextInputType.phone,
      hintText: 'Mobile No',
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

  ListTile buildJobField(BuildContext context) {
    return  ListTile(
      title: Text(
        job ?? 'Select a job',
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
        textAlign: TextAlign.start,
      ),
      // Display the selected job or prompt to select
      trailing: Icon(Icons.arrow_drop_down),
      onTap: () async {
        final selectedJob = await showMenu<String>(
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
          removeError(error: 'Job is required'); // Remove error if job is selected
        }
      },
    );
  }

  void pickImage(BuildContext context) {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(content: const Text("Choose image source"), actions: [
        MaterialButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        MaterialButton(
          child: const Text("Gallery"),
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
        baseUrl: "https://apiezz.dalia-ezzat.com/api",
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    try {
      final response = await dio.post(
        "/v1/jobs/searchData",
        data: {
          "search": {
            "langId": 2,
          },
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVlYTQzZjIyLTI5MzktNDc4YS04OTcxLWFhM2U2ZWVlYmFhZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiIxNTQuMTgwLjIyLjEwNyIsInRlbmFudCI6InJvb3QiLCJpbWFnZV91cmwiOiIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IiIsImV4cCI6MTczMzgzMjM5MH0.beV7cPDcb90jXSa8kH1QJ_6tcHO4WdoBeygkH-PYRW4", // Replace with your actual token
          },
        ),
      );
      if (response.statusCode == 200) {
        print("a");
        // Successful response
        JobListModel jobListModel = JobListModel.fromJson(response.data);
        selectJob = jobListModel.data;
        print(selectJob);// Save full job data if needed
        jobNames = selectJob?.map((job) => job.jobName ?? '').toList() ?? [];
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
