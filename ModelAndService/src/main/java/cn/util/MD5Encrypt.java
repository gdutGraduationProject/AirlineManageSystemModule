package cn.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/**
 * Created by ChenGeng on 2017/2/15.
 */
public class MD5Encrypt {

    /**
     * MD5加密
     * @param password 密码明文
     * @param salt 加密盐
     * @return 密码密文
     */
    public String encryption(String password, String salt){
        String plainText = composePasswordSalt(password,salt);
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(plainText.getBytes());
            byte b[] = md.digest();

            int i;

            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            //32位加密
            return buf.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 验证密码是否正确
     * @param sourcePassword 未加密、需验证的密码
     * @param salt 加密盐
     * @param password 加密后的密码
     * @return 验证结果：true正确，false错误
     */
    public boolean passwordCheck(String sourcePassword,String salt,String password){
        String encryptedString = encryption(sourcePassword,salt);
        return encryptedString.equals(password);
    }

    /**
     * 密码与盐的合成
     * @param password 密码明文
     * @param salt
     * @return
     */
    private String composePasswordSalt(String password, String salt){
        return password+salt;
    }

    /**
     * 用于生成加密盐
     * @return 加密盐
     */
    public String createSalt(){
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }

}
