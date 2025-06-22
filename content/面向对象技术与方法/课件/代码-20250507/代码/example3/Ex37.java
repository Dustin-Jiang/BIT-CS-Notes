package example3;

import java.util.Arrays;

public class Ex37 {

    /**
     * @param args
     */
    public static void main(String[] args) {
        int[] a = new int[]{32, 32, 96, 10, 29, 55};
//
//		for(int i=0; i<a.length; i++){
//			a[i] = (int)(Math.random()*100);
//		}

        System.out.println(Arrays.toString(a));  //以"[32, 32, 96, 10, 29, 55]"形式打印输出
        Arrays.sort(a);   //对数组a进行排序
        System.out.println(Arrays.toString(a));  //以"[10, 29, 32, 32, 55, 96]"形式打印输出


        int[] b=Arrays.copyOf(a,a.length);
        b[0]=1;
        System.out.println(Arrays.toString(a));
        System.out.println(Arrays.toString(b));
    }

}
