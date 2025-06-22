package example3;

import java.util.Scanner;

public class Ex36 {
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        System.out.print("输入要打印的杨辉三角形的行数:");
        int n = scn.nextInt();

        int[][] tri = new int[n][];   //创建n行

        //第1行第1个元素为0
        tri[0] = new int[1];
        tri[0][0]=1;

        for(int i=1; i<tri.length; i++){  //一行一行地处理
            tri[i] = new int[i+1];  //行号i从0开始，第i行有i+1个元素

            tri[i][0]=tri[i][i]=1;   //第一个和最后一个元素是1

            //中间每个元素=上一行两个元素之和
            for(int j=1; j<i; j++){
                tri[i][j]=tri[i-1][j-1]+tri[i-1][j];
            }
        }

        for(int i=0; i<tri.length; i++){
            for (int j=0; j<tri[i].length; j++){
                System.out.printf("%4d", tri[i][j]);
            }
            System.out.println();
        }

        for(int[] rows: tri){  //二维数组的每行是一维数组，迭代变量是一维数组元素类型int[]
            for(int element :rows){  //对每行进行迭代，迭代的对象为一维数组元素rows
                System.out.printf("%4d",element);
            }
            System.out.println();
        }
    }




}
