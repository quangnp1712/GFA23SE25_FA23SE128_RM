package com.realman.becore.util;

import java.util.Objects;

public class AppUtil {
    public static Boolean stringHasLength(String content) {
        return Objects.nonNull(content) && content.length() > 0;
    }
}
