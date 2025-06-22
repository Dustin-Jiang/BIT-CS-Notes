package example2;

public class Ex23 {
	//	public static void main(String[] args) {
//		/*int a=10,b=20;
//
//		System.out.println("a+b="+a+b);
//		System.out.println("a+b="+(a+b));
//		*/
//
//		int a=0,b=10,c=3;
//		System.out.println( a!=0 && b/a-c>0 );
//		//System.out.println( a!=0 & b/a-c>0 );
//		System.out.println( a!=0 ^ b!=0  );
//
//	}
	public static void main(String[] args) {
		int a=0,b=20,c=3;

		System.out.println( a!=0 && b/a-c>0 );  //成功避免发生除以0的运算
		//System.out.println( a!=0 & b/a-c>0 );   //程序会因除以0的异常而中断

		System.out.println( a!=0 ^ b!=0);          //a和b中只有一个为0
	}


}
