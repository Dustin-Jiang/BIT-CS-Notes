package example2;

public class Ex262 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		int a=1.2345;   //编译出错 Type mismatch: cannot convert from double to int
//
//		byte b = 1;
//
//		b=b+1;// 编译出错 Type mismatch: cannot convert from int to byte
//
//		float c = 1.5;     // 编译出错 Type mismatch: cannot convert from double to float

		int a=(int)1.2345;

		byte b = 1;
		b=(byte)(b+1);

		float c = (float)1.5;

		System.out.println((byte)300);
	}

}
