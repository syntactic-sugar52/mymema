// import 'package:flutter/cupertino.dart';
// import 'package:my_mema/models/cards.dart';
// import 'package:my_mema/models/teams.dart';
// import 'package:my_mema/services/database.dart';
//
// //step 2 update state from db
// class CurrentTeam extends ChangeNotifier {
//   Teams _currentTeam = Teams();
//   Cards _currentCard = Cards();
//   Teams get getCurrentTeam => _currentTeam;
//   Cards get getCurrentCard => _currentCard;
//
//   void updateStateFromDatabase(String teamId) async {
//     try {
//       _currentTeam = await Database().getTeamInfo(teamId);
//       _currentCard =
//           await Database().getCurrentCardInfo(teamId, _currentTeam.cardId);
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }
// }
