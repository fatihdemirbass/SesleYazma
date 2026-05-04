#!/bin/bash
# Sesle Yazma Kurulum Scripti - fatihdemirbass

echo "🎙️ CachyOS/Arch Sesle Yazdırma Kurulumu Başlıyor..."

# 1. Gerekli paketleri yükle
echo "📦 Bağımlılıklar yükleniyor..."
sudo pacman -S --needed xdotool ydotool unzip wget --noconfirm

# Nerd-dictation yüklü mü kontrol et, değilse yay ile kur
if ! command -v nerd-dictation &> /dev/null; then
    echo "⚙️ nerd-dictation kuruluyor..."
    yay -S nerd-dictation-git --noconfirm
fi

# 2. Türkçe modeli indir ve ayarla
echo "🌍 Türkçe dil modeli indiriliyor (yaklaşık 40MB)..."
wget -O model.zip https://alphacephei.com

echo "📂 Klasörler düzenleniyor..."
unzip model.zip
rm model.zip
mv vosk-model-small-tr-0.3 $HOME/model-tr

# 3. Kolay kullanım için bir alias (takma ad) ekle
echo "📝 Terminale 'sesle-yaz' komutu ekleniyor..."
echo "alias sesle-yaz='nerd-dictation begin --vosk-model-dir=\$HOME/model-tr --timeout 3.0 --input-tool=XDOTOOL --v-type-args \"--clearmodifiers\"'" >> ~/.bashrc
echo "alias sesle-yaz='nerd-dictation begin --vosk-model-dir=\$HOME/model-tr --timeout 3.0 --input-tool=XDOTOOL --v-type-args \"--clearmodifiers\"'" >> ~/.zshrc

echo "✅ KURULUM TAMAMLANDI!"
echo "-------------------------------------------------------"
echo "Kullanmak için terminali kapatıp açın veya 'source ~/.bashrc' yazın."
echo "Komut: sesle-yaz"
echo "Kısayol için ayarlardan bu komutu eklemeyi unutmayın!"
