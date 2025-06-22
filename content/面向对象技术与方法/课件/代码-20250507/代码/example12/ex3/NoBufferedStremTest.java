package example12.ex3;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

public class NoBufferedStremTest {
    public static void main(String[] args) {
        try(
                FileInputStream fis = new FileInputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/a.jpg");
                FileOutputStream fos = new FileOutputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/ex3/c.jpg");
        ){
            int data;
            Date d1 = new Date();
            while((data=fis.read())!=-1){
                fos.write(data);
            }
            Date d2 = new Date();
            System.out.println("不使用缓冲区的消耗时间："+(d2.getTime()-d1.getTime()));


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
