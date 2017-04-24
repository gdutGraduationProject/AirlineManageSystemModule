package cn.util;

import java.util.UUID;

/**
 * Created by ChenGeng on 2017/2/28.
 */
public class UuidGenerator {

    public String uuidGenerate(){
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }

}
