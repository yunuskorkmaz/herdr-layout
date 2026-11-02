# herdr-setup

Herdr masaüstü uygulamasının kişisel ayarları: `main-issues` layout'u, kısayollar
ve sonradan eklenen mod'lar. Herdr'ın kendi mod'ları burada yok; uygulama onları
kendisi kurar.

| Mod | Ne yapar | Gerekenler |
|---|---|---|
| `tabs-graph` | Üst sekme çubuğu | — |
| `issues` | GitHub issue paneli | `gh` (+ `gh auth login`), `curl` |
| `git-graph` | Git geçmişi grafiği | `git` |
| `git-changes` | Git değişiklikleri paneli | `git` |
| `revive` | Kapanan oturumları geri açma (`cmd-shift-r`) | `node` |
| `system` | Durum çubuğunda CPU/RAM/GPU | macOS |
| `quota` | Durum çubuğunda ajan kotaları | `npm install -g quota-axi`, bir kez `quota-axi --allow-keychain-prompt` |

## Yeni makinede kurulum

1. Herdr'ı kur, bir kez açıp kapat (`~/.config/herdr-app` oluşsun).
2. Herdr açıkken:
   ```sh
   git clone https://github.com/yunuskorkmaz/herdr-setup ~/projects/herdr-setup
   ~/projects/herdr-setup/install.sh
   ```
   Script dosyaları kopyalar, üzerine yazdıklarının yedeğini
   `~/.config/herdr-app.backup-<tarih>` altına alır, her mod'u `herdr-app check`
   ile dener, layout'a geçer ve eksik programları listeler.

Herdr sürümü bu ayarların yapıldığı sürümle aynı ya da daha yeni olmalı.

## Değişiklikleri repoya almak

Herdr'da bir şey değiştirdikten sonra:

```sh
./export.sh && git add -A && git commit -m "..." && git push
```

Yeni bir mod ya da layout eklediysen önce `files.sh` içindeki listeye ekle.
