import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final _openAI = OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(receiveTimeout: 2000),
      isLogger: true);

  Future<String> getResponse(String message) async {
    try {
      final request = CompleteText(prompt: message, model: kTranslateModelV3);

      final response = await _openAI.onCompleteText(request: request);
      if (response != null) {
        return response.choices[0].text.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  void dispose() {
    _openAI.close();
  }
}
