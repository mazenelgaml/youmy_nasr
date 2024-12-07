import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant/components/empty_view.dart';
import 'package:merchant/data/model/Category.dart';
import 'package:merchant/data/model/Product.dart';

import '../../../../../../components/custom_button.dart';
import '../../../../../../components/custom_text.dart';
import '../../../../../../components/custom_text_form_field.dart';
import '../../../../../../components/rounded_icon_btn.dart';
import '../../../../../../util/Constants.dart';
import '../../../../../../util/keyboard.dart';
import '../../../../../../util/size_config.dart';
import '../../components/products_data.dart';
import '../../filter/filter_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //region variables
  final String TAG = "Add New Product ";
  String? productName, factoryName, description, uml, price, priceAfterDiscount;
  final _formKey = GlobalKey<FormState>();
  List<String?> errors = [];
  final List<String> uomList = [
    "Select Unit",
    "Unit 1",
    "Unit 2",
    "Unit 3",
    "Unit 4"
  ];

  final List<String> categoriesList=["All"];
  var selectedUnit = "Select Unit";
   Category? selectedCategory ;
  int selectedImage = 0;
  var _pickedImage = File("");

//endregion

  //region helper functions
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  CustomTextFormField buildProductNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Product Name',
      onPressed: (value) {
        productName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPProductNameNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPProductNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPProductNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildFactoryNameField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Factory Name',
      onPressed: (value) {
        factoryName = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPFactoryNameNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPFactoryNameNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildDescriptionField() {
    return CustomTextFormField(
      textInputType: TextInputType.text,
      hintText: 'Description',
      onPressed: (value) {
        description = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPDescriptionNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPDescriptionNullError);
        }
        return null;
      },
    );
  }

  DropdownButton<String> buildUOMField() {
    return DropdownButton(
      hint: const CustomText(
        text: 'Unit Of Measure',
      ),
      iconSize: 40,
      isExpanded: true,
      value: selectedUnit,
      items: uomList.map((String unit) {
        return DropdownMenuItem<String>(
          child: Text(unit),
          value: unit,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedUnit = value.toString();
        });
      },
    );
  }

  // DropdownButton<Category> buildCategoryField() {
  //
  //
  //   return DropdownButton(
  //     hint: const CustomText(
  //       text: 'Category',
  //     ),
  //     iconSize: 40,
  //     isExpanded: true,
  //     value:  selectedCategory,
  //     items: demoCategories.map((category) {
  //       return DropdownMenuItem<Category>(
  //         child: Text(category.title),
  //         value: category,
  //       );
  //     }).toList(),
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCategory = value;
  //       });
  //     },
  //   );
  // }

  GestureDetector buildCategoryField() {
    return GestureDetector(
      onTap:(){
        Navigator.pushNamed(context, FilterScreen.routeName);
      } ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          CustomText(
            text: 'Category',
          ),
          Icon(Icons.arrow_drop_down_outlined,size: 40,)
        ],
      ),
    );
  }
  CustomTextFormField buildPriceField() {
    return CustomTextFormField(
      textInputType: TextInputType.number,
      hintText: 'Price',
      onPressed: (value) {
        price = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPPriceNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPPriceNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPPriceNullError);
        }
        return null;
      },
    );
  }

  CustomTextFormField buildPriceAfterDiscountField() {
    return CustomTextFormField(
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      hintText: 'Price After Discount',
      onPressed: (value) {
        priceAfterDiscount = value;
      },
      onValidate: (value) {
        if (value!.isEmpty) {
          addError(error: kPPriceAfterDiscountNullError);
          return "";
        } else if (value
            .toString()
            .isEmpty) {
          addError(error: kPPriceAfterDiscountNullError);
          return "";
        }
        return null;
      },
      onChange: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPPriceAfterDiscountNullError);
        }
        return null;
      },
    );
  }

//endregion

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              children: [
                buildSmallProductPreview(0),
                buildSmallProductPreview(0),
                buildSmallProductPreview(0),
                Spacer(),
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {

                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    _pickImage();
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildProductNameField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildFactoryNameField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildDescriptionField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildCategoryField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildUOMField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildProductNameField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPriceAfterDiscountField(),
            SizedBox(height: getProportionateScreenHeight(40)),
            CustomButton(
              text: "Create",
              press: () {
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedImage = index;
          });
        },
        child:  SizedBox(
          width: getProportionateScreenWidth(70),
          height: getProportionateScreenHeight(70),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: getImage(_pickedImage),
          ),
        ),
    );
  }

  void _pickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Choose image source"), actions: [
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

        setState(() {
          _pickedImage = File(pickedFile.path);
          print('_pickedImage ${_pickedImage}');
        });
      }
    });
  }

  ImageProvider getImage(File file) {
    if (file.path.isEmpty) {
      return const AssetImage("assets/images/logo.png");
    } else {
      return FileImage(file);
    }
  }
}
