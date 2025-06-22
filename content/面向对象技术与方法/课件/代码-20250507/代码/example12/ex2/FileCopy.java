package example12.ex2;

import java.io.FileInputStream;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileCopy {
    public static void main(String[] args) {
        int code = 123456;
        int data;

        try(
                FileInputStream fis=new FileInputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/a.jpg");
                FileOutputStream fos = new FileOutputStream("/Users/janegeng/Documents/javaClassWorkspace/lecture/src/example12/ex2/b.jpg");
        ) {
            while((data=fis.read())!=-1){
                fos.write(data^code);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

