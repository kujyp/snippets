import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.firebase.FirebaseApp;
import android.app.Application;

import java.io.File;

public class AppInfo extends Application {
    private static Context mContext = null;

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;

        FirebaseApp.initializeApp(this);
    }

    public static @NonNull Context getGlobalContext() {
        return AssertUtils.ensureNotNull(mContext);
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
        mContext = null;
    }

    public static boolean isOnline(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {
            return true;
        }
        return false;
    }

    public static String getVersion(Context context) {
        PackageInfo info = null;
        try {
            info = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return info.versionName;
    }
}
