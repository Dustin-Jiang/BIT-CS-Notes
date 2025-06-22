package example9.ex3;

import java.util.InputMismatchException;
import java.util.Scanner;

public class InputException {

    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        int maxTimes = 5; //最多猜的次数
        System.out.println("游戏开始...最多可以猜"+maxTimes+"次");
        int x  = (int)(Math.random()*100+1);  //被猜的数
        System.out.println(x);
        int count = 0;
        while(true){
            System.out.print( count==0 ? "开始猜数..." : "继续猜...");
            try{
                count++;
                int guessNumber = scn.nextInt();
                if(guessNumber<x){
                    System.out.println("小了");
                }else if(guessNumber>x){
                    System.out.println("大了");
                }else{
                    System.out.println("恭喜猜对了");
                    break;
                }
            }catch(InputMismatchException e){
                scn.next();   //接收不合法的数据
                System.out.println("请输入1-100之间的整数");
            }
            if(count==maxTimes){
                System.out.println("猜数失败，您没有机会了！");
                break;
            }
        }
    }

}
