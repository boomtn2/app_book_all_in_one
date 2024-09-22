import 'client_base.dart';

enum Voice { local, hamy, nu, namminh }

class VoiceTTSApi {
  final Client _client;
  final int _maxInput;
  final String name;
  final String _keyJsonUrlMp3;
  final String? _keyParam;
  final String? _keyBody;
  final Map<String, dynamic>? _paramText;
  final Map<String, dynamic>? _bodyWiki;
  VoiceTTSApi(
      {required Client client,
      required int maxInput,
      required this.name,
      required String keyJsonUrlMp3,
      Map<String, dynamic>? paramText,
      Map<String, dynamic>? bodyWiki,
      String? keyParam,
      String? keyBody})
      : _client = client,
        _maxInput = maxInput,
        _keyJsonUrlMp3 = keyJsonUrlMp3,
        _paramText = paramText,
        _bodyWiki = bodyWiki,
        _keyBody = keyBody,
        _keyParam = keyParam;

  Client get client {
    if (_bodyWiki != null) {
      _client.bodyWiki = _bodyWiki;
    }
    if (_paramText != null) {
      _client.param = _paramText;
    }
    return _client;
  }

  int get maxInput => _maxInput;
  String get keyJsonUrlMp3 => _keyJsonUrlMp3;

  void data(String text) {
    if (_keyBody != null) {
      _bodyWiki![_keyBody] = text;
    }

    if (_keyParam != null) {
      _paramText![_keyParam] = text;
    }
  }
}

Map<Voice, VoiceTTSApi> listVoiceApi = {
  Voice.hamy: VoiceTTSApi(
      client: Client.data(
        baseURLClient: 'https://lazypy.ro/tts/request_tts.php',
        headerWiki: {
          'Content-Type': 'application/json',
          'Content-Encoding': 'br',
          'Accept': '*/*',
          'Origin': 'https://lazypy.ro',
          // 'Referer':
          //     'https://lazypy.ro/tts/?voice=vi-VN-HoaiMyNeural&service=Bing%20Translator&text=th%E1%BB%AD%20c%C3%A1i%20n%C3%A0o&lang=Vietnamese&g=A',
          'Sec-Ch-Ua':
              '"Microsoft Edge";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36 Edg/123.0.0.0'
        },
        methodWiki: 'Post',
        url: '',
      ),
      paramText: {
        'service': 'Bing Translator',
        'voice': 'vi-VN-HoaiMyNeural',
        'text': ''
      },
      keyParam: 'text',
      maxInput: 1000,
      name: 'Hoai My',
      keyJsonUrlMp3: 'audio_url'),
  Voice.namminh: VoiceTTSApi(
      client: Client.data(
        baseURLClient: 'https://lazypy.ro/tts/request_tts.php',
        headerWiki: {
          'Content-Type': 'application/json',
          'Content-Encoding': 'br',
          'Accept': '*/*',
          'Origin': 'https://lazypy.ro',
          // 'Referer':
          //     'https://lazypy.ro/tts/?voice=vi-VN-HoaiMyNeural&service=Bing%20Translator&text=th%E1%BB%AD%20c%C3%A1i%20n%C3%A0o&lang=Vietnamese&g=A',
          'Sec-Ch-Ua':
              '"Microsoft Edge";v="123", "Not:A-Brand";v="8", "Chromium";v="123"',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36 Edg/123.0.0.0'
        },
        methodWiki: 'Post',
        url: '',
      ),
      paramText: {
        'service': 'Bing Translator',
        'voice': 'vi-VN-NamMinhNeural',
        'text': ''
      },
      keyParam: 'text',
      maxInput: 1000,
      name: 'Hoai My',
      keyJsonUrlMp3: 'audio_url'),
  Voice.nu: VoiceTTSApi(
    client: Client.data(
      baseURLClient: 'https://text2audio.cc/api/audio',
      headerWiki: {'Content-Type': 'application/json'},
      methodWiki: 'Post',
    ),
    maxInput: 500,
    name: 'Nu Text2Audio',
    keyJsonUrlMp3: 'url',
    bodyWiki: {"language": "vi-VN", "paragraphs": '', "splitParagraph": false},
    keyBody: 'paragraphs',
  )
};
