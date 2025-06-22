package example12.ex5;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class ObjectStreamTest {
    public static void main(String[] args) {

        try(
                FileOutputStream fos = new FileOutputStream("object.dat");
                ObjectOutputStream oos = new ObjectOutputStream(fos);
        ) {
            Student stu = new Student("Lucy", 15);
            System.out.println(stu.getName()+","+stu.getAge());
            System.out.println(stu);
            oos.writeObject(stu);
            oos.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

        try(
                FileInputStream fis = new FileInputStream("object.dat");
                ObjectInputStream ois = new ObjectInputStream(fis);
        ) {
            Student stu = (Student)ois.readObject();
            System.out.println(stu.getName()+","+stu.getAge());
            System.out.println(stu);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
