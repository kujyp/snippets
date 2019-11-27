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
