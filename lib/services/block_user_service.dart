import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';

class BlockUserService with ListenableServiceMixin {
  final ChefService chefService = locator<ChefService>();
  final CullinaryschoolService cullinaryschoolService = locator<CullinaryschoolService>();
  List<String> blockedAccounts = [];

  void onInit() {
    blockedAccounts = userDetails!.blockedAccounts!;
  }

  // chefService.chefs.removeWhere((element) => blockedAccounts.contains(element.uid));
  Future<bool> updateBlockedAccounts(List<String> blockedAccounts) async {
    final CollectionReference usersCollection =
        firebasestore.collection('users');

    try {
      // Check if the document exists
      final DocumentSnapshot document = await usersCollection
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      

      if (document.exists) {
        // If the document exists, update the blocked_accounts field
        await usersCollection
            .doc(firebaseAuth.currentUser!.uid)
            .update(
                {'blocked_accounts': FieldValue.arrayUnion(blockedAccounts)});
                if(userDetails!.followers!.contains(blockedAccounts.first))
              { await usersCollection
            .doc(userDetails!.uid)
            .update(
                {'followers': FieldValue.arrayRemove(blockedAccounts)});  }

                if(userDetails!.following!.contains(blockedAccounts.first)){
                  await usersCollection.doc(userDetails!.uid).update({
                    'following': FieldValue.arrayRemove(blockedAccounts),
                  });
                }

        // Remove blocked accounts from the list of blocked accounts    
userDetails = UserModel.fromSnapshot(document);
        blockedAccounts.add(blockedAccounts.last);
        chefService.chefs
            .removeWhere((element) => blockedAccounts.contains(element.uid));

        cullinaryschoolService.cullinaryscools
            .removeWhere((element) => blockedAccounts.contains(element.uid));

        notifyListeners();
      } else {
        // If the document doesn't exist, create it with the blocked_accounts field
        await usersCollection
            .doc(firebaseAuth.currentUser!.uid)
            .set({'blocked_accounts': blockedAccounts});
      }
      log('Blocked accounts updated successfully.');
      return true;
    } catch (e) {
      log('Error updating blocked accounts: $e');
      return false;
    }
  }

  void updateCurrentUserModel(
      {required UserModel localModel, required String userId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update(localModel.toJson());
    blockedAccounts.removeWhere((element) => blockedAccounts.contains(userId));
    
    notifyListeners();
  }
}
