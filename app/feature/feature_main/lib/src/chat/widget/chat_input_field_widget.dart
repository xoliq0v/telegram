import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  bool get _isWriting => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              onPressed: () {},
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 20,
                        maxHeight: 120,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                _isWriting ? Icons.send : CupertinoIcons.mic,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                if (_isWriting) {
                  // TODO: Send message
                  _controller.clear();
                } else {
                  // TODO: Record voice message
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}