package chapter5.ex7.v2;

public class Test {
    public static void main(String[] args) throws CloneNotSupportedException {

        Student stu1 = new Student("Lucy",15);

        Student stu2 = stu1.clone();

        System.out.println(stu1);
        System.out.println(stu2);

    }
}
