import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

import 'custom_button.dart';

class EventApprovalAlertDialog extends StatelessWidget {
  const EventApprovalAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Message',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              20.sH,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Wait for Approval.'),
                  10.sW,
                  const Icon(
                    Icons.approval,
                  ),
                ],
              ),
              30.sH,
              CustomButton(
                  height: 50,
                  title: 'Ok',
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
