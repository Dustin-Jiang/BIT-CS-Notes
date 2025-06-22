package example2;

public class Ex215 {
	/**
	 * 金字塔
	 */
	public static void main(String[] args) {
		printPyramid(7);
		printPyramid('g');
	}

	public static void printPyramid(int n){ //打印n行数字组成的金字塔
		for(int i=1; i<=n; i++){
			for(int j=1; j<=n-i; j++){
				System.out.print(" ");
			}
			for(int j=1; j<=i; j++){
				System.out.print(j);
			}
			for(int j=i-1; j>=1; j--){
				System.out.print(j);
			}
			System.out.println();
		}
	}

	public static void printPyramid(char c){ //打印n行字符组成的金字塔
		for(char row='a'; row<=c; row++){
			//空格
			for(int i=1; i<=c-row; i++){
				System.out.print(" ");
			}
			//升序部分
			for(char ch='a'; ch<=row; ch++){
				System.out.print(ch);
			}
			//降序部分
			for(char ch=(char)(row-1); ch>='a'; ch--){
				System.out.print(ch);
			}
			System.out.println();
		}
	}

}
