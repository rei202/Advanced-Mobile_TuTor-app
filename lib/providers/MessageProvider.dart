import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Message.dart';

class MessageNotifier extends StateNotifier<List<Message>>{
  MessageNotifier() : super([]);
  void add(Message message){
    state = [...state, message];
    // print(state);
  }
  void addList(List<Message> message){
    state = message;
  }
  void deleteList(){
    state = [];
  }

}
final messagesProvider = StateNotifierProvider<MessageNotifier, List<Message>>((ref) => MessageNotifier(),
);