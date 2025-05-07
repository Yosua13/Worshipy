Penjelasan ->
- Swift Package Manager (SPM) sebenarnya adalah alat dependency management bawaan dari ekosistem Swift/Apple, bukan bagian langsung dari Flutter. Namun, jika kamu mengembangkan plugin atau integrasi native iOS di dalam Flutter, kamu bisa memanfaatkan Swift Package Manager untuk mengelola dependency Swift atau iOS native framework (misalnya Alamofire, Firebase, atau library lain).

Perbandingan SPM vs Cocoapods ->
| Aspek                     | Swift Package Manager (SPM)                     | CocoaPods                                             |
| ------------------------- | ----------------------------------------------- | ----------------------------------------------------- |
| 🔧 Native Apple Support   | Native (terintegrasi langsung dengan Xcode)     | Bukan native, harus install CLI `pod` secara manual   |
| ⚡ Kecepatan Build         | Lebih cepat dan ringan                          | Lebih lambat karena banyak dependensi dan konfigurasi |
| 📁 Struktur Integrasi     | Tidak mengubah file proyek secara agresif       | Memodifikasi `project.xcworkspace`, `Pods`, dll.      |
| 📦 Dependency Resolving   | Menggunakan Git URL langsung                    | Banyak tersedia dari CocoaPods repo                   |
| 🔄 Cache Management       | Lebih stabil dan cepat                          | Sering perlu `pod deintegrate`, `pod install` ulang   |
| 🎯 Target Integration     | Perlu Xcode manual target linking               | Otomatis dikelola lewat Podfile                       |
| 🌍 Dukungan Library       | Hanya library modern yang pakai `Package.swift` | Hampir semua library iOS tersedia                     |
| 📱 Dukungan Multiplatform | Lebih baik: mendukung macOS, tvOS, watchOS      | Terbatas dibandingkan SPM                             |

Kelebihan -> 
- Tanpa perlu install CocoaPods: Lebih ringan untuk proyek CI/CD dan pemula.
- Versi lebih mudah dikontrol: Bisa langsung pilih versi/tag dari GitHub.
- Performa build lebih cepat: Karena tanpa overhead Pods dan skrip tambahan.
- Stabil di macOS dan Catalyst: Sangat cocok jika Flutter multiplatform iOS-macOS.
- Konflik dependency lebih minim: Tidak ada “Podfile.lock” yang sering kacau.

Kekurangan -> 
- Integrasi Flutter belum otomatis: Tidak ada flutter pub add → perlu manual lewat Xcode.
- Harus buka Xcode dan atur target: Tidak sepraktis CocoaPods dengan Podfile.
- Kurangnya dokumentasi Flutter resmi: Mayoritas plugin Flutter masih pakai CocoaPods.
- Tidak semua library support SPM: Banyak library lama belum punya Package.swift.
- Kurva belajar lebih tinggi: Harus paham Xcode target dependencies dan build phase.
- Komunitas tidak sebanyak Cocoapods

Dokumentasi Resmi ->
Anda tidak perlu menginstal Ruby dan CocoaPods jika proyek Anda menggunakan Swift Package Manager.

-> Mengaktifkan Swift Package Manager
- flutter upgrade (Menggunakan versi 3.24 atau lebih tinggi)
- flutter config --enable-swift-package-manager
- flutter run (Jalankan aplikasi iOS menggunakan menggunakan terminal) maka swift package manager auto keinstall
- Manual https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers


-> Mematikan Swift Package Manager
- secara Local
flutter:
    disable-swift-package-manager: true (pubspec.yaml)
- secara Global
flutter config --no-enable-swift-package-manager
- Manual https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers

Bahan renungan -> 
- Podfile auto donwload ketika menjalankan flutter run (Flutter mendukung SPM, realitanya banyak plugin Flutter (seperti image_picker, geolocator) masih tergantung pada CocoaPods untuk integrasi native-nya)
- Ketika memakai package image_picker dan geolocator terdapat error not found (Kemungkinan karena masih banyak plugin yang belum support SPM sehingga terjadi error)
- Sedikit banget dokumentasinya hahaha
+ Lebih simpel karena tidak perlu menjalankan command pod install
+ auto install package dependencies iOS

Rekomendasi -> 
saat ini masih gunakan cocoapods karena banyak package yang belum mendukung SPM sehingga banyak terjadi error ketika menjalankan aplikasi