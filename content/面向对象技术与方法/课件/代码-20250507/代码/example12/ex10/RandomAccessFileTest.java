package example12.ex10;

import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Scanner;

public class RandomAccessFileTest {
    public static void main(String[] args) throws IOException{

        //以"rw"方式创建RandomAccessFile对象
        RandomAccessFile raf = new RandomAccessFile( "data.dat", "rw");
        for(int i=0; i<10; i++){
            int number = (int)(Math.random()*1000000);
            System.out.println("["+(i+1)+"]\t"+number);
            raf.writeInt(number);
        }

        long fp = raf.getFilePointer();

        Scanner scn = new Scanner(System.in);
        System.out.print("输入要读取的整数的序号1-10(0结束):");
        int position = scn.nextInt();
        while( position!=0 ){
            raf.seek((position-1)*4);
            int number = raf.readInt();
            System.out.println(number);
            System.out.print("输入要读取的整数的序号1-10(0结束):");
            position = scn.nextInt();
        }
    }
}

