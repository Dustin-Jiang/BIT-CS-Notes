package example3;

import java.util.Scanner;

public class Ex32 {

    /**
     * 例3-1：输入n个学生的成绩，并打印成绩高于平均分的学生。
     */
    public static void main(String[] args) {
        Scanner scn = new Scanner(System.in);

        System.out.print("输入学生的人数:");
        int count = scn.nextInt();
        double[] score = new double[count]; //依据输入值动态确定数组长度


        double sum=0;
        for(int i=0; i<score.length; i++){
            System.out.print("输入学生的成绩:");
            score[i]=scn.nextDouble();
            sum+=score[i];
        }
        double average = sum/count;
        System.out.println("平均成绩为：" + average);

        System.out.println("高于平均分的学生有：");
        for(int i=0; i<score.length; i++){
            if(score[i]>average){
                System.out.println("学生" + (i+1)+", 成绩："+score[i]);
            }
        }
    }

    int[] array = new int[]{1,2,3,4,5};


}
