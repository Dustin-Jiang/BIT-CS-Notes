package example9.ex1;
import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class ExceptionDemo {

    public static void main(String[] args) {
        Scanner scn  = new Scanner(System.in);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        System.out.print("输入生日(yyyy-MM-dd):");
        String birthStr = scn.next();

        try {
            //如果birthStr不可解析, 就抛出异常
            Date birth = sdf.parse(birthStr);
            System.out.println("生日:"+sdf.format(birth));
        } catch (ParseException e) { //捕获异常
        System.out.println("日期格式错!");
		System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}
