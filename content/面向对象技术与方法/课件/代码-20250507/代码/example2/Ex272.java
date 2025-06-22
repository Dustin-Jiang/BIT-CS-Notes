package example2;


import java.util.Scanner;

public class Ex272 {
	/**
	 * 根据输入的运算符（+-* /）组织各种运算
	 */
	public static void main(String[] args) {
		//输入运算符
		System.out.println("输入运算符：");
		Scanner scn = new Scanner(System.in);
		char operator=scn.next().charAt(0);   //获取键入字符串的第一位，得到一个字符

		//输入两个运算数
		System.out.println("输入两个运算数：");
		double x=scn.nextDouble();
		double y=scn.nextDouble();
		double std = 0;
		int flag = 1; //1：合法运算符；0：非法运算符

		//输出算式
		if(operator=='+'){
			System.out.print(""+x+operator+y+"=");
			std = x+y;
		}else if(operator=='-'){
			System.out.print(""+x+operator+y+"=");
			std = x-y;
		}else if(operator=='*'){
			System.out.print(""+x+operator+y+"=");
			std = x*y;
		}else if(operator=='/'){
			System.out.print(""+x+operator+y+"=");
			std = x/y;
		}else{
			flag = 0;
		}

		if(flag==0){
			System.out.println("请输入+、-、*或者/");
		}else{
			//输入答案
			double res = scn.nextDouble();
			//判断对错
			if(Math.abs(res-std)<1e-6){
				System.out.println("答案正确");
			}else{
				System.out.println("回答错误");
			}
		}
	}
}
