package example9.ex1;

import java.time.LocalDate;

import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Scanner;

public class ExceptionDemo2 {

    public static void main(String[] args) {
        Scanner scn  = new Scanner(System.in);
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");


        System.out.print("输入生日(yyyy-MM-dd):");
        String birthStr = scn.next();

        try {
            //如果birthStr不可解析, 就抛出异常
            LocalDate birth = LocalDate.parse(birthStr, dateFormat);
            System.out.println(birth);
        } catch (DateTimeParseException e) { //捕获异常
            System.out.println("日期格式错!");
            e.printStackTrace();
        }
    }
}

