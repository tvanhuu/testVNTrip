import 'package:flutter/material.dart';
import 'package:testExample1/src/helpers/Dimension.dart';

void dialogLoading(BuildContext context, {String mms = "Xin vui lòng chờ..."}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: EdgeInsets.all(width(context, 16)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 16),
              Text(mms),
            ],
          ),
        ),
      );
    },
  );
}
