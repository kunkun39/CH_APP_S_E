package com.changhong.common.pinying;

import org.springframework.util.StringUtils;

/**
 * User: Jack Wang
 * Date: 15-11-9
 * Time: 下午4:17
 */
public class EnglistHelper {

    public static String toSearchFullName(String name) {
        if (StringUtils.hasText(name)) {
            return name.replace(" ", "").toUpperCase();
        }
        return "";
    }

    public static String toSearchShortName(String name) {
        if (StringUtils.hasText(name)) {
            StringBuilder builder = new StringBuilder();
            String[] tokens = StringUtils.delimitedListToStringArray(name, " ");
            for (String token : tokens) {
                if (StringUtils.hasText(token)) {
                    builder.append(token.substring(0, 1));
                }
            }
            return builder.toString().toUpperCase();
        }
        return "";
    }

    public static void main(String[] args) {
        String s = "Jack Wang k ";
        System.out.println(toSearchFullName(s));
        System.out.println(toSearchShortName(s));

        s = "";
        System.out.println(toSearchFullName(s));
        System.out.println(toSearchShortName(s));

        s = null;
        System.out.println(toSearchFullName(s));
        System.out.println(toSearchShortName(s));

        s = " kfjeof efe foejf oef eof ";
        System.out.println(toSearchFullName(s));
        System.out.println(toSearchShortName(s));
    }
}
