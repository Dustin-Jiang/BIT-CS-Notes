package example9.ex8;

import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class UserRegiste {
    private List<String> users;

    public UserRegiste() {
        users = new LinkedList<String>();
    }

    public void registe(String email) throws EmailExistException {
        if(email.equalsIgnoreCase("zhangsan@126.com")){	//简单业务处理
            throw new EmailExistException("该邮箱已注册...");
        }else{
            users.add(email);
        }
    }

    public static void main(String[] args) {
        Scanner scn  = new Scanner(System.in);
        System.out.print("邮箱:");
        String email = scn.next();

        try {
            new UserRegiste().registe(email);
        } catch (EmailExistException e) {//捕获EmailExistException异常
            e.printStackTrace();	//打印自定义异常信息
        }
    }

}

