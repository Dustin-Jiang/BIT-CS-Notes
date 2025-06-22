package example12.ex1;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileCopy {
    public static void main(String[] args) {
        FileInputStream fis=null;
        FileOutputStream fos=null;
        //指定加密密码
        int code=123456;
        int data;
        try {
            fis=new FileInputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/a.jpg");
            fos=new FileOutputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/ex1/b.jpg");

            while((data=fis.read())!=-1){
                fos.write(data);
 //               fos.write(data^code);  //边读边加密边写
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            if(fis!=null) try{fis.close();} catch(IOException e){}
            if(fos!=null) try{fos.close();} catch(IOException e){}
        }
    }

}