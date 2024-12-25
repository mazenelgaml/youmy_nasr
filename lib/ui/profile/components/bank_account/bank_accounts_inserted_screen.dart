import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/services/translation_key.dart';
import 'package:merchant/ui/profile/components/bank_account/bank_account_screen.dart';
import '../../../../util/Constants.dart';
import '../../profile_controller/profile_controller.dart';

class BankAccountsInsertedScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
    builder: (ProfileController controller) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(bankAccountsTitle.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = constraints.maxWidth > 600 ? 500 : constraints.maxWidth * 0.9;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ListView.builder(
                itemCount: controller.bankAccounts.length,
                itemBuilder: (context, index) {
                  final account = controller.bankAccounts[index];
                  return Center(
                    child: SizedBox(
                      width: cardWidth,
                      child: BankAccountWidget(
                        bankAccountName: account.bankAccountName ?? "N/A",
                        bankAccountNumber: account.bankAccountNumber ?? "N/A",
                        bankCode: account.bankCode ?? "N/A",
                        bankBranchCode: account.bankBranchCode ?? "N/A",
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>BankAccountScreen()); // Replace this with your action.
        },
        backgroundColor: KPrimaryColor,
        child: const Icon(Icons.add),
      ),

    );});
  }
}

class BankAccountWidget extends StatelessWidget {
  final String bankAccountName;
  final String bankAccountNumber;
  final String bankCode;
  final String bankBranchCode;

  const BankAccountWidget({
    Key? key,
    required this.bankAccountName,
    required this.bankAccountNumber,
    required this.bankCode,
    required this.bankBranchCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            colors: [KChipColor,
              KPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankAccountName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(accountNumber.tr, bankAccountNumber),
                _buildInfoColumn(bank.tr, bankCode),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(accountBranch.tr, bankBranchCode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
