plugins { id("com.android.application") }

dependencies {
    implementation("dev.rikka.shizuku:api:13.1.5")
    implementation("dev.rikka.shizuku:provider:13.1.5")
}
android {
 namespace = "com.ghostai.v8"
 compileSdk = 36
 defaultConfig { applicationId = "com.ghostai.v8"; minSdk = 26; targetSdk = 35; versionCode = 82; versionName = "8.2.0" }
}
