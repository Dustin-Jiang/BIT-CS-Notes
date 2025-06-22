package example2;

public class Ex22 {

    public static void main(String[] args) {
        int  i = 10, j = 8, m = 11, n = 20, k, g;

        System.out.println(i++);		//找到变量i除了++外的运算是什么
        System.out.println(++j);		//找到变量i除了++外的运算是什么

        System.out.println("i="+i);
        System.out.println("j="+j);

        k = m++;			//找到变量m除了++外的运算是什么
        System.out.println("k="+k);
        System.out.println("m="+m);

        g = 3*(++n);		//找到变量n除了++外的运算是什么
        System.out.println("g="+g);
        System.out.println("n="+n);
    }

}
