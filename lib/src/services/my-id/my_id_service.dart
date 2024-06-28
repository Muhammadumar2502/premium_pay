// import 'package:flutter/services.dart';
import 'package:myid/enums.dart';
import 'package:myid/myid.dart';
import 'package:myid/myid_config.dart';
import 'package:premium_pay_new/src/core/endpoints/endpoints.dart';

class MyIdService {
  // static const platform = MethodChannel('flutter.native/myid');
  static Future<Map?> request(
      {required String KEY_PASSPORT_DATA,
      required String KEY_DATE_OF_BIRTH}) async {
    print(KEY_PASSPORT_DATA);
    print(KEY_DATE_OF_BIRTH);

    String? error;
    MyIdResult? result;

    try {
      String clientId = Endpoints.myid_client_id;
      String clientHashId = Endpoints.myid_clientHashId;
      String clientHash = Endpoints.myid_clientHash;
      // 'premium_pay_sdk-iQEq84nAHSs6uoBOhgAlvG6CYAOGvE6GsdDWlNlq'; // for test

      final myIdResult = await MyIdClient.start(
          config: MyIdConfig(
        clientId: clientId,
        clientHash: clientHash,
        clientHashId: clientHashId,
        passportData: KEY_PASSPORT_DATA,
        dateOfBirth: KEY_DATE_OF_BIRTH,
        buildMode: MyIdBuildMode.PRODUCTION,
        //  buildMode: MyIdBuildMode.DEBUG,
        resolution: MyIdResolution.RESOLUTION_480,
        imageFormat: MyIdImageFormat.JPG,
        withPhoto: true,
        locale: MyIdLocale.UZBEK,
        cameraShape: MyIdCameraShape.CIRCLE,
        residency: MyIdResidentType.RESIDENT,
        entryType: MyIdEntryType.FACE,
        threshold: 0.5,
        organizationDetails: const MyIdOrganizationDetails(phone: "712022202"),
      ));

      result = myIdResult;
    } catch (e) {
      print("KKKKKKKKKKKKKKKKK");
      print(e.toString());
      error = e.toString();
      result = null;
    }

    return {"result": result, "error": error};
    // return await platform.invokeMethod(
    //   'runSDK',
    //   <String, dynamic>{
    //     'KEY_PHONE_NUMBER': "712022202", // Organization phone number
    //     'KEY_CLIENT_ID':
    //         "premium_pay_sdk-iQEq84nAHSs6uoBOhgAlvG6CYAOGvE6GsdDWlNlq",
    //     'KEY_PASSPORT_DATA': KEY_PASSPORT_DATA, // "AB6935244",
    //     'KEY_DATE_OF_BIRTH':
    //         KEY_DATE_OF_BIRTH, // "31.07.2000", // Format: dd.MM.yyyy
    //     // 'KEY_SDK_HASH': "", // Optional
    //     // 'KEY_EXTERNAL_ID': "", // Optional
    //     'KEY_THRESHOLD': 0.5, // 0.5 until 1.0
    //     'KEY_BUILD_MODE': "DEBUG", // PRODUCTION or DEBUG
    //     'KEY_ENTRY_TYPE': "AUTH", // AUTH or FACE
    //     'KEY_RESIDENT_TYPE':
    //         "RESIDENT", // USER_DEFINED, RESIDENT and NON_RESIDENT  // changed
    //     'KEY_LOCALE': "uz", // uz, en, ru
    //     'KEY_CAMERA_SHAPE': "CIRCLE", // CIRCLE or ELLIPSE
    //     'KEY_WITH_PHOTO': true
    //   },

    // );
  }
}
