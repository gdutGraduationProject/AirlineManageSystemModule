package cn.util;

/**
 * Created by ChenGeng on 2017/2/21.
 */
public class GlobalContants {

    public static final String REQUEST_ERROR_REASON = "error_reason";
    public static final String REQUEST_SUCCESS_TEXT = "success_text";
    public static final String SESSION_ERROR_REASON = "error_reason";
    public static final String SESSION_LOGIN_CUSTOMER = "customer";
    public static final String SESSION_LOGIN_STAFF = "staff";
    public static final String SESSION_LOGIN_USER_TYPE = "userType";
    public static final String RESPONSE_MESSAGE = "message";
    //被登录拦截器拦截的请求之前的跳转路径
    public static final String SESSION_LOGIN_BACK_URL= "login_back_url";
    public static final String SESSION_LOGIN_BACK_PARAMETER_STRING = "login_back_parameter_string";
    public static final String SYSTEM_DOMAIN_ADDRESS="http://172.17.3.13";
    public static final String SYSTEM_MANAGER_PORTID="6078";
    public static final String SYSTEM_CUSTOMER_PORTID="6078";



    /**
     * 返回的状态
     */
    public class ResponseStatus{
        public static final String SUCCESS = "success";//成功
        public static final String ERROR = "error";//错误
    }

    /**
     * 用户的类型
     */
    public class UserType{
        public static final String CUSTOMER = "customer";//航空公司职员
        public static final String STAFF = "staff";//普通顾客
    }

}
