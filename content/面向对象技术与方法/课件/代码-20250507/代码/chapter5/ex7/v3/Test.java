package chapter5.ex7.v3;

public class Test {
    public static void main(String[] args) throws CloneNotSupportedException{

        Teacher teacher = new Teacher("Grace");
        Student stu1 = new Student("Lucy", 15, teacher);
        System.out.println("stu1:"+stu1);

        Student stu2 = stu1.clone();
        System.out.println("stu2:"+stu2);

        System.out.println("------------------");

        stu1.getTeacher().setName("Kenzo");
        System.out.println("stu1:"+stu1);

        System.out.println("stu2:"+stu2);
    }
}
