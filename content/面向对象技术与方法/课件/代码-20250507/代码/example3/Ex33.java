package example3;

import java.util.Scanner;

public class Ex33 {

    /**
     * 例3-2：冒泡法排序
     */
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        System.out.print("输入排序元素的个数:");
        int count = scn.nextInt();
        int[] array = new int[count]; //依据输入值动态确定数组长度

        System.out.println("排序前的数据为：");
        for(int i=0; i<array.length; i++){
            array[i]=(int)(Math.random()*100);
            System.out.print(array[i]+"  ");
        }

        //冒泡法排序
        for(int i=0; i<array.length-1 ;i++){
            for(int j=0; j<array.length-1-i; j++){
                if(array[j]>array[j+1]){
                    int tmp=array[j];
                    array[j]=array[j+1];
                    array[j+1]=tmp;
                }
            }
        }

        System.out.println();
        System.out.println("排序后的结果为：");
        for(int i=0; i<array.length; i++){
            System.out.print(array[i]+"  ");
        }
    }

}
