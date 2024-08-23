import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/wallet/models/wallet_txn_model.dart';
import 'package:stryde_mobile_app/features/wallet/widgets/txn_tab.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/container_list_tile.dart';

class WalletView extends ConsumerStatefulWidget {
  const WalletView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletViewState();
}

class _WalletViewState extends ConsumerState<WalletView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Wallet",
        context: context,
        implyLeading: true,
        toolbarHeight: 70.h,
        color: Colors.transparent,
        isTitleCentered: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: 15.padH,
            child: Container(
              padding: 25.0.padA,
              decoration: BoxDecoration(
                color: Palette.buttonBG,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 8.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        PhosphorIconsBold.wallet,
                        color: Palette.strydeOrange,
                      ),
                      10.sbW,
                      "Total Balance".txt16()
                    ],
                  ).alignCenterLeft(),
                  30.sbH,
                  "₦1,000,000".txt24(fontW: F.w6),
                  40.sbH,
                  Container(
                    width: 150.w,
                    padding: 10.0.padA,
                    decoration: BoxDecoration(
                      color: Palette.buttonBG,
                      borderRadius: BorderRadius.circular(21.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 8.0,
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIconsBold.uploadSimple,
                          color: Palette.strydeOrange,
                          size: 22.h,
                        ),
                        10.sbW,
                        "Withdraw".txt14()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.sbH,
          Padding(
            padding: 15.padH,
            child: "Pending"
                .txt16(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(),
          ),
          10.sbH,
          SizedBox(
            height: 75.h,
            child: ListView.builder(
              padding: 7.5.padH,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: 7.5.padH, // Add some padding if necessary
                  child: PendingTransactionsTab(),
                );
              },
            ),
          ),
          20.sbH,
          Padding(
            padding: 15.padH,
            child: "Transactions"
                .txt16(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(),
          ),
          GroupedListView<Transaction, DateTime>(
            padding: 20.padV,
            shrinkWrap: true,
            reverse: true,
            elements: transactions,
            groupBy: (Transaction transaction) {
              return DateTime(
                transaction.transactionDate.year,
                transaction.transactionDate.month,
                transaction.transactionDate.day,
              );
            },
            groupHeaderBuilder: (Transaction transaction) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: DateFormat.yMMMd()
                  .format(transaction.transactionDate)
                  .txt14()
                  .alignCenterLeft(),
            ),
            itemBuilder: (BuildContext context, Transaction transaction) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.h),
                child: OptionSelectionContainerTile(
                  horizontalContentPadding: 18.w,
                  tileBxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                  containerColor: Palette.buttonBG,
                  interactiveTrailing: true,
                  interactiveTrailingWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      10.sbH,
                      "₦${transaction.transactionAmount}".txt18(fontW: F.w6),
                    ],
                  ),
                  titleLabel:
                      transaction.transactionType == TransactionType.deposit
                          ? "Deposit"
                          : "Withdrawal",
                  subtitleLabel: transaction.attachedAccountNumber,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
