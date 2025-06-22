package example2;

import java.util.Scanner;

public class Ex213 {

    /**
     * 打印一个指定大小的n×n的棋盘，用星号表示落棋的位置，棋盘位置的编号用0~9，a~z依次表示
     */
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        System.out.print("输入棋盘的大小:");
        int column = scn.nextInt();  //打印的行数和列数

        //输出第一行抬头
        System.out.print("\t");
        for(int i=0; i<column; i++){
            if (i<10){ //输出数字表示行号
                System.out.print(i+"\t");
            }else{  //依次用字母a,b...表示行号
                System.out.print((char)('a'+i-10)+"\t");
            }
        }
        System.out.println();

        //输出棋盘
        for (int i=0; i<column; i++){
            //输出行号
            if (i<10){
                System.out.print(i+"\t");
            }else{
                System.out.print((char)('a'+i-10)+"\t");
            }

            //输出星号
            for (int j=1; j<=column; j++)
                System.out.print("*\t");

            System.out.println();
        }
    }

}
