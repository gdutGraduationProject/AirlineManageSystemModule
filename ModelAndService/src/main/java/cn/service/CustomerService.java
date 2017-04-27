package cn.service;

import cn.bean.Customer;
import cn.bean.repository.CustomerRepo;
import cn.util.MD5Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.regex.Pattern;


/**
 * Created by ChenGeng on 2017/2/16.
 */
@Component
public class CustomerService {

    @Autowired
    CustomerRepo customerRepo;

    MD5Encrypt md5Encrypt = new MD5Encrypt();

    public Customer findCustomerById(String id){
        return customerRepo.findOne(id);
    }

    public Customer encryptCustomerPassword(Customer customer){
        String unencryptPassword = customer.getPassword();
        String salt = customer.getSalt();
        if(salt == null || salt.equals("")){
            salt = md5Encrypt.createSalt();
            customer.setSalt(salt);
        }
        String encryptedPassword = md5Encrypt.encryption(unencryptPassword,salt);
        customer.setPassword(encryptedPassword);
        return customer;
    }

    public Customer save(Customer customer){
        return customerRepo.save(customer);
    }

    /**
     * 根据用户名密码查找相应的用户，如果验证通过返回该用户，验证失败返回空
     * @param loginUsername 用户登录时输入的用户名，可能为系统用户名、手机号或邮箱
     * @param loginPassword 用户登录时输入的登录密码
     * @return
     */
    public Customer customerLogin(String loginUsername,String loginPassword){
        Customer customer = findCustomer(loginUsername);
        if(customer == null){
            // 根据用户输入的用户名、手机或邮箱找不到该用户，登录失败
            return null;
        }else{
            // 根据用户输入的用户名、手机或邮箱找到相应的用户，进行验证操作
            if(md5Encrypt.passwordCheck(loginPassword,customer.getSalt(),customer.getPassword())){
                //密码验证通过
                return customer;
            }else{
                //密码输入错误，验证不通过
                return null;
            }
        }
    }

    /**
     * 根据登录凭证查找相应的用户
     * @param loginString 登录凭证，可以为用户名、已通过验证的手机号码或邮箱
     * @return 查找到的用户
     */
    public Customer findCustomer(String loginString){
        String stringType = stringType(loginString);
        if(stringType.equals("error")){
            return null;
        }else{
            if(stringType.equals("phone")){
                return customerRepo.findByCheckedPhoneNumberAndIsDelete(loginString,false);
            }else if(stringType.equals("username")){
                return customerRepo.findByUsernameAndIsDelete(loginString,false);
            }else{
                return customerRepo.findByCheckedEmailAndIsDelete(loginString,false);
            }
        }
    }

    /**
     * 根据传入的字符串，判断该字符串是用户名、手机号还是邮箱
     * @param string 需要判断的字符串
     * @return "phone":手机号;"username":用户名;"email":邮箱;"error":输入有误
     */
    public String stringType(String string){
        if(string.indexOf("@")!=-1 && string.indexOf(".")!=-1){
            return "email";
        }else if(string.length()==11 && allNumber(string)==true){
            return "phone";
        }else{
            String regEx = "^[a-zA-Z][a-zA-Z0-9_]{5,11}$";
            Pattern pattern = Pattern.compile(regEx);
            boolean isUsername = pattern.matcher(string).matches();
            if(isUsername == true){
                return "username";
            }else{
                return "error";
            }
        }
    }

    /**
     * 判断该字符串是不是全为数字
     * @param string 需要判断的字符串
     * @return 结果
     */
    private boolean allNumber(String string){
        for(int i = 0 ; i<string.length();i++){
            if(string.charAt(i)>'9' || string.charAt(i)<'0'){
                return false;
            }
        }
        return true;
    }

}
