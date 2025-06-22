package example2;

import java.util.Scanner;

public class MathTest {

	public static void main(String[] args) {
		//显示菜单
		System.out.println("***请按编号选择使用哪个功能***");
		System.out.println("1.判断某数是否为素数");
		System.out.println("2.获取亲密数");
		System.out.println("3.算术练习器");
		System.out.println("0.退出");

		run();
	}

	public static void run(){
		Scanner scn = new Scanner(System.in);

		System.out.print("输入菜单编号:");
		int option = scn.nextInt();
		int x;

		while(option!=0){
			switch(option){
				case 1://素数
					System.out.println("请输入一个数字：");
					x = scn.nextInt();
					if(isPrime(x)){
						System.out.println(x+"是素数");
					}else{
						System.out.println(x+"不是素数");
					}
					break;
				case 2: //亲密数
					System.out.println("你想求几以内的亲密数：");
					x = scn.nextInt();

					int count = getIntimacy(x);
					if(count==0){
						System.out.println("该范围内没有亲密数");
					}else{
						System.out.println("共有亲密数"+count+"对");
					}
					break;
				case 3:  //算术练习器
					System.out.println("输入要练习题目的个数：");
					x = scn.nextInt();
					excercise(x);
			}//switch end
			System.out.print("输入菜单编号:");
			option = scn.nextInt();
		}
		System.out.println("再见!");
	}

	public static boolean isPrime(int x){
		for(int div=2; div<=Math.sqrt(x); div++){
			if(x%div==0){
				return false;
			}
		}
		return true;
	}

	public static int getIntimacy(int n){
		int a,b,count=0,sumDivB=0;

		for(a=1; a<n; a++){ //亲密数之一：a
			b=1;   //亲密数之二：b（ a的因子之和）
			for(int i=2; i<=Math.sqrt(a); i++){  //因子在根号a范围内
				if(a%i==0){
					b=b+i+a/i;  //i和a/i同时都是a的因子					
				}
			}

			if(a<b){  //只输出a<b的情况
				sumDivB=1; //sumDivB：b的因子之和
				for(int i=2; i<=Math.sqrt(b); i++){
					if(b%i==0){
						sumDivB=sumDivB+i+b/i;
					}
				}
			}
			if(sumDivB==a){//b的因子之和sumDivB与a相等
				System.out.println(a+"和"+b+"是一对亲密数");
				count++;
			}
		}
		return count;
	}
	public static void excercise(int count){//算术练习
		int m,n,op,resInput,resCalculate = 0 ;
		int countr=0;    //计算正确的数量
		int countw=0;	 //计算错误的数量

		do{
			do{//获取两个随机运算数(两位数)
				m=(int)(Math.random()*100);
				n=(int)(Math.random()*100);
			}while(m<10 || n<10);

			//随机得到一个运算符0~3,0:加法;1:减法; 2:乘法; 3:除法
			op=(int)(Math.random()*4);

			switch(op){
				case 0: System.out.println(m+"+"+n+"="); resCalculate=m+n; break;
				case 1: System.out.println(m+"-"+n+"="); resCalculate =m-n; break;
				case 2: System.out.println(m+"*"+n+"="); resCalculate =m*n; break;
				case 3: System.out.println(m+"/"+n+"="); resCalculate =m/n;
			}

			Scanner sc=new Scanner(System.in);
			resInput=sc.nextInt();  //用户输入的答案

			if(resInput == resCalculate){
				System.out.println("答案正确!");
				countr++;
			}else {
				System.out.println("答案错误!");
				countw++;
			}
		}while((countr+countw)<count);

		System.out.print("你做对" +countr+"道题！");
		System.out.println("做错" +countw+"道题！");
	}
}
