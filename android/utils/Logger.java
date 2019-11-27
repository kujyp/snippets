import android.util.Log;

public class Logger {
    private static final String TAG = "Logger";
    private static final boolean isDebugBuild = BuildConfig.DEBUG;
    private static final int REAL_METHOD_POS = 2;

    private static String getPrefix() {
        StringBuilder sb = new StringBuilder();

        try {
            StackTraceElement[] ste = new Throwable().getStackTrace();
            StackTraceElement realMethod = ste[REAL_METHOD_POS];

            sb.append("[");
            sb.append(realMethod.getFileName());
            sb.append(":");
            sb.append(realMethod.getLineNumber());
            sb.append(":");
            sb.append(realMethod.getMethodName());
            sb.append("()] ");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sb.toString();
    }

    private static String getFileName() {
        StackTraceElement[] ste = new Throwable().getStackTrace();
        StackTraceElement realMethod = ste[REAL_METHOD_POS];

        String fileName = realMethod.getFileName();

        return fileName.substring(0, fileName.lastIndexOf("."));
    }

    public static void d() {
        if (isDebugBuild) {
            Log.d(TAG, getPrefix());
        }
    }

    public static void d(String msg) {
        if (isDebugBuild) {
            Log.d(TAG, getPrefix() + msg);
        }
    }

    public static void d(String variableName, Object value) {
        if (isDebugBuild) {
            Log.d(TAG, getPrefix() + variableName + "=[" + value + "]");
        }
    }
}