package com.changhong.common.utils;


import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.security.Security;


/**
 * @author Jack Wang
 */
public class DesUtils {
    private static String DEFAULT_ALGORITHM_NAME = "DES";
    private static String DEFAULT_KEY_NAME = "CH";
    private static Cipher encryptCipher;
    private static Cipher decryptCipher;

    static {
        initial();
    }

    public static String getEncString(String text) {
        return byteArr2HexStr(encrypt(text.getBytes()));
    }

    public static String getDesString(String text) {
        return new String(decrypt(hexStr2ByteArr(text)));
    }

    private static void initial() {
        Security.addProvider(new com.sun.crypto.provider.SunJCE());
        Key key = null;
        try {
            key = getKey(DEFAULT_KEY_NAME.getBytes());
            encryptCipher = Cipher.getInstance(DEFAULT_ALGORITHM_NAME);
            encryptCipher.init(Cipher.ENCRYPT_MODE, key);
            decryptCipher = Cipher.getInstance(DEFAULT_ALGORITHM_NAME);
            decryptCipher.init(Cipher.DECRYPT_MODE, key);
        } catch (Exception e) {

        }
    }

    private static String byteArr2HexStr(byte[] arrB) {
        int iLen = arrB.length;
        StringBuffer sb = new StringBuffer(iLen * 2);
        for (int i = 0; i < iLen; i++) {
            int intTmp = arrB[i];
            while (intTmp < 0) {
                intTmp = intTmp + 256;
            }
            if (intTmp < 16) {
                sb.append("0");
            }
            sb.append(Integer.toString(intTmp, 16));
        }
        return sb.toString();
    }

    private static byte[] hexStr2ByteArr(String text) {
        byte[] arrB = text.getBytes();
        int iLen = arrB.length;

        byte[] arrOut = new byte[iLen / 2];
        for (int i = 0; i < iLen; i = i + 2) {
            String strTmp = new String(arrB, i, 2);
            arrOut[i / 2] = (byte) Integer.parseInt(strTmp, 16);
        }
        return arrOut;
    }

    private static byte[] encrypt(byte[] arrB) {
        try {
            return encryptCipher.doFinal(arrB);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private static byte[] decrypt(byte[] arrB) {
        try {
            return decryptCipher.doFinal(arrB);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private static Key getKey(byte[] arrayBytesTemp) {
        byte[] bytesTemp = new byte[8];

        int len = arrayBytesTemp.length < bytesTemp.length ? arrayBytesTemp.length : bytesTemp.length;
        for (int i = 0; i < len; i++) {
            bytesTemp[i] = arrayBytesTemp[i];
        }

        Key key = new SecretKeySpec(bytesTemp, DEFAULT_ALGORITHM_NAME);
        return key;
    }

    public static void main(String[] args) {
        String after = getDesString("c2eff1f37ffed70b59a899817d0e66f7a5a03ff67d2a5829");
        System.out.println(after);
    }
}