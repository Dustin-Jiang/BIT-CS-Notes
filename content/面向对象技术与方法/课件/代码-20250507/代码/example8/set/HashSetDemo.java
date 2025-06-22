package example8.set;

import java.util.*;

public class HashSetDemo {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Set<Student> students = new HashSet<>();

        students.add(new Student("Lucy", 20));
        students.add(new Student("Hellen", 19));
        students.add(new Student("Andrew", 21));
        students.add(new Student("Andrew", 19));	//没有与之完全相同的对象，存储
        students.add(new Student("Andrew", 21));	//该对象已存在，被舍弃


        for(Student stu: students){
            System.out.println(stu.getName()+", "+stu.getAge());
        }
    }

}

