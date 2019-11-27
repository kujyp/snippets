## firebase database
- q firebase 파이어베이스 데이터베이스 realtimedatabase firestore
1. Firebase project 생성, database 생성
https://firebase.google.com/docs/android/setup
2. firebase 에 android app 등록
패키지이름
3. google-services.json 등록
4. project-level build.gradle
```
classpath 'com.google.gms:google-services:4.3.3'  // Google Services plugin
```
5. app-level build.gradle (bottom of the file)
```
apply plugin: 'com.google.gms.google-services'  // Google Play services Gradle plugin
```
6. dependency
https://firebase.google.com/docs/database/android/start
```
implementation 'com.google.firebase:firebase-database:19.2.0'
```


#### etc
Settings > General > Your project tab > Google Cloud Platform (GCP) resource location 
asia-northeast1
- asia-east2, 홍콩. asia-northeast1, 도쿄. asia-northeast2, 오사카