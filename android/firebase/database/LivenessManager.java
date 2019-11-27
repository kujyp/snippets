package io.github.etftrading.manager;

import android.Manifest;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.telephony.TelephonyManager;

import androidx.annotation.NonNull;
import androidx.core.content.ContextCompat;

import com.google.android.gms.tasks.Task;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import io.github.etftrading.data.repo.IntervalRepo;
import io.github.etftrading.ui.GlobalApplication;
import io.github.etftrading.utils.AssertUtils;
import io.github.etftrading.utils.Configs;
import io.github.etftrading.utils.CurrentTime;

public class LivenessManager {
    private static DatabaseReference sLivenessRef;
    private static String sStartedTime = CurrentTime.getCurrentTime();
    static {
        sLivenessRef = FirebaseDatabase.getInstance().getReference(getUuid(GlobalApplication.getGlobalContext()))
                .child("liveness");
        sLivenessRef.child(sStartedTime).setValue(CurrentTime.getCurrentTime());
        cleanHistoriesAsync();
    }

    private static void cleanHistoriesAsync() {
        sLivenessRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                Iterable<DataSnapshot> children = dataSnapshot.getChildren();
                long childrenCount = dataSnapshot.getChildrenCount();

                int idx = 0;
                for (DataSnapshot each: children) {
                    if (idx < childrenCount - Configs.PRESERVE_COUNT_LIVENESS_HISTORY) {
                        each.getRef().removeValue();
                    }
                    idx++;
                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }

    private LivenessManager() {
    }

    public static void init() {
        IntervalRepo.getIntervalObservable()
                .subscribe((ignored) -> {
                    sLivenessRef.child(sStartedTime).setValue(CurrentTime.getCurrentTime());
                });
    }

    public static String getUuid(@NonNull Context context) {
        AssertUtils.assertNotNull(context);

        UUID uuid;
        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        String savedUuid = sharedPreferences.getString("uuid", null);
        if (savedUuid != null) {
            return savedUuid;
        }

        String uniqueId = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);
        if (uniqueId == null || uniqueId.isEmpty()) {
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                throw new AssertionError("READ_PHONE_STATE permission not granted.");
            }
            uniqueId = ((TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE)).getDeviceId();
        }
        if (uniqueId == null || uniqueId.isEmpty()) {
            AssertUtils.assertNotTrue(false, "Unexpected case.");
        }
        uuid = UUID.nameUUIDFromBytes(uniqueId.getBytes(StandardCharsets.UTF_8));

        sharedPreferences.edit()
                .putString("uuid", uuid.toString())
                .apply();

        return uuid.toString();
    }
}
