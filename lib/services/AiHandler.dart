
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:lettutor/env/env.dart';

class AIHandler{
  final openAI = OpenAI.instance.build(token: tokenChatGPT, // API key here
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),);

  Future<String> getResponse(List<Map<String,String>> messages) async {
    try {
      final request = ChatCompleteText(messages: messages, maxToken: 200, model: ChatModel.gptTurbo0301);
  //[
      //         Map.of({"role": "user", "content": message})
      //       ]
      final response = await openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message!.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return e.toString();
    }
  }

  void dispose(){
    openAI.cancelAIGenerate();
  }
}