import androidx.annotation.NonNull;
import androidx.annotation.Nullable;


public class AssertUtils {
    public static void assertNotNull(Object o, String msg) {
        if (o == null) {
            throw new AssertionError(msg);
        }
    }

    public static void assertNotNull(Object o) {
        assertNotNull(o, "");
    }

    public static void assertNotTrue(boolean b, String msg) {
        if (!b) {
            throw new AssertionError(msg);
        }
    }

    public static void assertNotTrue(boolean b) {
        assertNotTrue(b, "");
    }

    @NonNull
    public static <T> T ensureNotNull(@Nullable T o, String msg) {
        if (o == null) {
            throw new AssertionError(msg);
        }

        return o;
    }

    @NonNull
    public static <T> T ensureNotNull(@Nullable T o) {
        return ensureNotNull(o, "object is Null");
    }
}
