import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_app/control/modules/date.dart';
import 'package:service_app/control/modules/message.dart';
import 'package:service_app/control/modules/offer.dart';
import 'package:service_app/control/modules/store.dart';
import 'package:telephony/telephony.dart';
import '../modules/product.dart';
import 'api.dart';
import 'locator.dart';
import 'package:easy_localization/easy_localization.dart';

class Message_provider {
  Api _api_read = locator_message_read<Api>();
  Api _api_write = locator_message_write<Api>();

  List<Message> messages;

  Future<List<Message>> fetchMessages() async {
    var result = await _api_read.getDataCollection();

    messages =
        result.docs.map((doc) => Message.fromsnapshot(doc, doc.id)).toList();

    for (var item in messages) {
      print("message item: ${item.body}");

      Message_provider().Send_Message_(item.body, item.client_number);
      Message_provider().removeMessage(item.id);
    }

    return messages;
  }

  Stream<QuerySnapshot> fetchMessagesAsStream(String search_by) {
    return _api_read.streamDataCollection();
  }

  Future<Message> getMessageById(String id) async {
    var doc = await _api_read.getDocumentById(id);
    return Message.fromMap(doc.data(), doc.id);
  }

  Future removeMessage(String id) async {
    await _api_read.removeDocument(id)
        // .then(
        //     (doc) async => await EasyLoading.showSuccess('great'.tr().toString()))
        ;
    return;
  }

  Future updatemessage(Message data, String id) async {
    await _api_read.updateDocument(data.toJson(), id).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));
    return;
  }

  Future addmessage(Message data) async {
    var result = await _api_write.addDocument(data.toJson()).then(
        (doc) async => await EasyLoading.showSuccess('great'.tr().toString()));

    return;
  }

  Send_Message_(String msg, List<String> numbers) async {
    print("message ${numbers.toString() + "'./. '" + msg}");

    Stream stream = Stream.fromFuture(Store().getSMSnumber_data());
    stream.listen((event) async {
      //add store name to the message
      msg = msg + "\n" + event.store_name;

      ///tcheck if my divice have the same number of sms
      if (event.sms_number == event.user_number) {
        print("message lacal ${numbers.toString() + "'./. '" + msg}");

        final telephony = Telephony.instance;
        final bool result = await telephony.requestPhoneAndSmsPermissions;

        if (result) {
          for (var item in numbers) {
            telephony.sendSms(
              to: item,
              message: msg,
              isMultipart: true,
              statusListener: (status) {
                print("statusListener ${status}");
              },
            );
          }
        }
      } else {
        print("message server${numbers.toString() + "'./. '" + msg}");

        Message message = Message(
            body: msg,
            client_number: numbers,
            date: (DateTime.now().millisecondsSinceEpoch).toString());
        await addmessage(message);
      }
    });
  }
}
