# 🎓 DiploChain

**DiploChain** est une solution innovante, sécurisée et transparente pour la vérification de l'authenticité des diplômes académiques. En s'appuyant sur un système décentralisé (simulé en local via Isar pour cette version), l'application vise à éradiquer la fraude documentaire académique et professionnelle, en particulier en Afrique.

---

## 🌟 Fonctionnalités Principales

L'application est divisée en **4 portails distincts**, accessibles depuis un menu unifié, adaptés aux différents acteurs du système éducatif et professionnel :

### 1. 🌍 Portail Public (Vérification Rapide)
* **Recherche par ID** : Permet à toute personne (parent, entreprise tierce, ambassade) de vérifier instantanément si un identifiant de diplôme correspond bien à un diplôme officiellement enregistré.
* **Résultat clair** : Affiche les informations de l'étudiant, de l'établissement et le statut de certification.

### 2. 🏢 Application Recruteur (Scanner)
* **Scan Rapide** : Les employeurs et recruteurs peuvent scanner le QR Code présent sur le CV d'un candidat pour vérifier immédiatement l'authenticité de son diplôme.
* **Historique** : Garde une trace locale des vérifications récemment effectuées.

### 3. 🏛️ Dashboard Université / Institution
* **Émission de Diplômes** : Les universités (ex: Université Joseph Ki-Zerbo, Unica, etc.) disposent d'une interface pour inscrire de nouveaux diplômes de manière immuable.
* **Tableau de Bord** : Vue d'ensemble sur le nombre de diplômes émis, les tendances et les vérifications effectuées.

### 4. 👨‍🎓 Espace Diplômé / Étudiant
* **Portefeuille Numérique** : L'étudiant a accès à tous ses diplômes certifiés dans un seul endroit.
* **Partage Sécurisé** : L'étudiant peut générer et partager son QR Code personnel avec des recruteurs pour prouver ses qualifications sans fournir de documents papier falsifiables.

---

## 🛠️ Technologies Utilisées

* **Framework** : [Flutter](https://flutter.dev/) (Dart) pour une compatibilité totale iOS, Android et Web.
* **Interface & Design** : Design system moderne et institutionnel (Couleur primaire : Vert Souverain).
* **Stockage Local & Web3 simulé** : [Isar Database](https://isar.dev/) (Base de données NoSQL ultra-rapide) pour stocker les diplômes émis et assurer une fluidité hors-ligne.
* **Scan QR Code** : `mobile_scanner`
* **Graphiques** : `fl_chart`
* **Icônes & Polices** : `lucide_icons` et `google_fonts`

---

## 🚀 Installation & Lancement

### Prérequis
* [Flutter SDK](https://docs.flutter.dev/get-started/install) installé (version >= 3.10.0)
* Android Studio / Xcode pour l'émulation mobile.

### Étapes

1. Clonez ce dépôt ou placez-vous dans le dossier du projet :
   ```bash
   cd Diplochain-1
   ```

2. Récupérez les dépendances :
   ```bash
   flutter pub get
   ```

3. Générez les fichiers de base de données (Isar schemas) :
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Lancez l'application :
   ```bash
   # Pour lancer sur un appareil connecté ou un émulateur
   flutter run

   # Pour compiler l'APK final (Android)
   flutter build apk
   ```

---

## 📱 Navigation & Expérience Utilisateur
Le système utilise une navigation fluide via un "Bottom Sheet" (Menu déroulant accessible via l'icône de liste `☰` en haut à droite) permettant de basculer instantanément d'un rôle à un autre sans redémarrer l'application.

---

**Développé avec ❤️ pour assurer l'intégrité académique.**
