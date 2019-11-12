
class SafeStringUtils {
    public static int safeParseInt(String str) {
        return safeParseInt(str, -1);
    }

    public static int safeParseInt(String str, int defaultValue) {
        int ret;
        try {
            ret = Integer.parseInt(str);
        } catch (NumberFormatException e) {
            ret = defaultValue;
        }
        return ret;
    }
}
