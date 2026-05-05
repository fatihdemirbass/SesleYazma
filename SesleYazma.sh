#!/bin/bash
# Sesle Yazma Kurulum Scripti

echo "🎙️ CachyOS/Arch Sesle Yazdırma Kurulumu Güncelleniyor..."

# 1. Gerekli paketleri yükle (Ses motoru ve klavye emülasyonu)
echo "📦 Bağımlılıklar yükleniyor..."
sudo pacman -S --needed xdotool unzip wget --noconfirm

# Nerd-dictation yüklü mü kontrol et, değilse yay ile kur
if ! command -v nerd-dictation &> /dev/null; then
    echo "⚙️ nerd-dictation kuruluyor..."
    yay -S nerd-dictation-git --noconfirm
fi

# 2. Türkçe modeli indir ve ayarla (Güncel Link)
MODEL_DIR="$HOME/model-tr"
echo "🌍 Türkçe dil modeli indiriliyor..."

# Eğer eski model varsa sil
if [ -d "$MODEL_DIR" ]; then
    rm -rf "$MODEL_DIR"
fi

# Güncel Vosk Türkçe Küçük Model
wget -O model-tr.zip https://alphacephei.com
echo "📂 Klasörler düzenleniyor..."
unzip -q model-tr.zip
mv vosk-model-small-tr-0.4 $MODEL_DIR
rm model-tr.zip

# 3. Kolay kullanım için alias'ı güncelle
echo "📝 Terminale sesle-yaz komutu ekleniyor..."

# Eski aliasları temizle (çift eklenmemesi için)
sed -i '/alias sesle-yaz=/d' ~/.bashrc
sed -i '/alias sesle-yaz=/d' ~/.zshrc

# Yeni alias ekle (Komut yapısı güncellendi)
ALIAS_CMD="alias sesle-yaz='nerd-dictation begin --vosk-model-dir=$MODEL_DIR --input-tool=xdotool'"

echo "$ALIAS_CMD" >> ~/.bashrc
echo "$ALIAS_CMD" >> ~/.zshrc

echo "✅ KURULUM/GÜNCELLEME TAMAMLANDI!"
echo "-------------------------------------------------------"
echo "Kullanmak için: source ~/.bashrc veya terminali yeniden açın."
echo "Komut: sesle-yaz"
echo "⚠️ Not: Mikrofonunuzun 'pavucontrol' üzerinden seçili olduğundan emin olun."
