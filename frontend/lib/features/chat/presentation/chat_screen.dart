import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> sessionData;

  const ChatScreen({super.key, required this.sessionData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'Client',
      'original': 'Hola, ¿el coche está disponible en el aeropuerto de Marrakech?',
      'language': 'Espagnol',
      'translated': 'Bonjour, est-ce que la voiture est disponible à l\'aéroport de Marrakech ?',
      'timestamp': '10:00',
    },
    {
      'sender': 'Agency',
      'original': 'نعم، السيارة جاهزة ويمكننا تسليمها لك مباشرة عند وصولك.',
      'language': 'Arabe',
      'translated': 'Oui, la voiture est prête et nous pouvons vous la livrer directement à votre arrivée.',
      'timestamp': '10:02',
    },
  ];

  String _userLanguage = 'Français';
  final List<String> _languages = ['Français', 'English', 'Espagnol', 'Arabe', 'Deutsch'];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final role = widget.sessionData['role_assigned'] ?? 'Client';

    // Mock translation logic based on the user's selected language
    String mockTranslation = '';
    if (role == 'Client') {
      mockTranslation = 'مرحباً، أود تأكيد الحجز من فضلك. (Traduit en Arabe)';
    } else {
      mockTranslation = 'Welcome, we will process your car rental shortly. (Translated to English)';
    }

    setState(() {
      _messages.add({
        'sender': role,
        'original': text,
        'language': _userLanguage,
        'translated': mockTranslation,
        'timestamp': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.sessionData['role_assigned'] ?? 'Client';

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Traducteur Intelligent'),
            Text('Chat B2C Client / B2B Agence', style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          // Select current active typing language
          DropdownButton<String>(
            value: _userLanguage,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.language, color: AppTheme.secondaryColor),
            underline: Container(),
            items: _languages.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang, style: const TextStyle(fontSize: 13, color: AppTheme.textPrimaryColor)),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _userLanguage = val);
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Informational Alert Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.primaryColor, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'SIIR traduit automatiquement les messages entre l\'agence et le client en temps réel.',
                    style: TextStyle(fontSize: 12, color: AppTheme.secondaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Message history list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg['sender'] == role;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? AppTheme.primaryColor : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                        bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message sender & label
                        Text(
                          '${msg['sender']} (${msg['language']})',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.white70 : AppTheme.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Original message
                        Text(
                          msg['original'],
                          style: TextStyle(
                            fontSize: 14,
                            color: isMe ? Colors.white : AppTheme.textPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(color: Colors.white24, height: 12),

                        // Automatic translation
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.translate, size: 12, color: AppTheme.secondaryColor),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                msg['translated'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: isMe ? Colors.white.withOpacity(0.9) : AppTheme.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            msg['timestamp'],
                            style: TextStyle(
                              fontSize: 9,
                              color: isMe ? Colors.white60 : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Message input bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Écrire en $_userLanguage...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
