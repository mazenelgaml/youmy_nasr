import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:merchant/services/translation_key.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en": {
      branchesScreenTitle:"Branches",
      ordersScreenTitle:"Orders",
      couriersScreenTitle:"Couriers",
      profileScreenTitle:"My Account",
      productScreenTitle:"Products",
      signInTitle:"Welcome to Yomy - Merchant",
      signInTextEmail:"Email/Phone No",
      signInTextPass:"Password",
      signInTextForgetPass:"Forget Password?",
      signInTextBTN: "Login",
      and:" and ",
      dontHaveAnAccount:"Don\'t have an account?",
      signUpTextBTN : "SignUp",
      PersonalInformation : "Personal Information",
      iAgreeTo: "I agree to",
      termsAndPrivacyPolicy: "Terms & Privacy Policy",
      next: "Next",
      haveAnAccount: "Have an account?",
      signUpName: "Name",
      signUpEmail: "Email",
      mobileNO: "Mobile NO",
      selectAJob: "Next",
      signUpPassword: "Have an account?",
      signUpConfirmPassword: "Confirm Password",

    },
    "ar": {
      branchesScreenTitle:"الفروع",
      ordersScreenTitle:"الطلبات",
      couriersScreenTitle:"مندوبين توصيل",
      profileScreenTitle:"حسابي",
      productScreenTitle:"المنتاجات",
      signInTitle: " Yomy - Merchant مرحبا بك   ",
      signInTextEmail: "البريد الإلكتروني" ,
      signInTextPass: "كلمة المرور" ,
      signInTextForgetPass: "نسيت كلمة المرور" ,
      signInTextBTN: "تسجيل الدخول" ,
      and:" و ",
      dontHaveAnAccount: "ليس لديك حساب؟",
      signUpTextBTN: "سجل الآن"


    }
  };
}