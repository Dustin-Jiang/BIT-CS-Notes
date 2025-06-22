package example2;

import java.util.Scanner;

public class Ex211 {

    /**
     * 输入两个正数，并利用欧几里德算法（辗转相除法）求它们的最大公约数
     */
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        int m,n,r;
        do{
            System.out.print("请输入两个正整数:");
            m=scn.nextInt();
            n=scn.nextInt();
        }while(m<=0||n<=0);

        r=m%n;    //循环前初始化：第一次计算余数
        while(r!=0){
            m=n;
            n=r;
            r=m%n;
        }
        System.out.println("它们的最大公约数是"+n);   //循环结束后的除数为最大公约数
    }
}
