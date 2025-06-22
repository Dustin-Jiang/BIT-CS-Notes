package example2;

import java.util.Scanner;
/**
 * 随机生成一个整数（1~100之间），由用户进行猜数，每次给出大小的提示，并记录猜数的次数
 */
public class Ex29{
	public static void main(String[] args) {
		Scanner scn = new Scanner(System.in);

		//1.生成一个被猜的数字
		int x = (int)(Math.random()*100+1);  //Math.random()随机生成[0,1)间的浮点数
		System.out.println("被猜的数字是："+x);

		//2.初始化循环变量guessNumber和计数器count
		System.out.println("输入你猜的数字：");
		int guessNumber = scn.nextInt();
		int count = 1;	//猜数的次数

		//3.猜数判断
		while(guessNumber!=x){
			if(guessNumber<x){
				System.out.println("小了");
			}else{
				System.out.println("大了");
			}
			System.out.print("输入你猜的数字：");
			guessNumber=scn.nextInt();
			count++;
		}
		System.out.println("正确！猜了"+count+"次");
		scn.close();
	}
}
