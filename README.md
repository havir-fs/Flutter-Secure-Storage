# Sample secure storage implementation for flutter

A sample Flutter application that shows the use of flutter_secure_storage library as a solution for store and encrypt data in Flutter. In this plugin Keychain is used for iOS and AES encryption is used for Android. AES secret key is encrypted with RSA and RSA key is stored in KeyStore.


## Notes:

 - There is a limitation of using KeyStore provider in Android. KeyStore was introduced in Android 4.3 (API level 18). So For using this feature the API level must be 18 (Android 4.3) or higher.
 
 - By default Android backups data on Google Drive. It can cause exception java.security.InvalidKeyException:Failed to unwrap key. For avoiding this error we could disable backup for this file(FlutterSecureStorage.xml). For do that you need firstly create an XML file called my_backup_rules.xml in the below directory with following content:

>-root-of-project-/android/app/src/main/res/xml/

```xml
<?xml version="1.0" encoding="utf-8"?>
<full-backup-content>
    <exclude domain="sharedpref" path="FlutterSecureStorage"/>
</full-backup-content>
```


Then in AndroidManifest.xml, add the android:fullBackupContent attribute to the <application> element. This attribute points to an XML file that contains backup rules. For example:

```xml
<application ...
    android:fullBackupContent="@xml/my_backup_rules">
</application>
```
