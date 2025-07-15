import emoji
import json

# Faqat Unicode emoji kalitlarini olish
all_emojis = list(emoji.EMOJI_DATA.keys())

# JSON formatga yozish
with open('emojis.json', 'w', encoding='utf-8') as f:
    json.dump(all_emojis, f, ensure_ascii=False, indent=2)

print(f"Total emojis: {len(all_emojis)}")