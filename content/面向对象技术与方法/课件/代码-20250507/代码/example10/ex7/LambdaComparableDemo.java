package example10.ex7;

import java.util.Arrays;

public class LambdaComparableDemo {

    public static void main(String[] args) {
        Student[] stu = { new Student("Anna",18), new Student("Lucy",21)};

        Arrays.sort(
                stu, (stu1, stu2) -> stu2.getAge()-stu1.getAge()
        );

        for(Student s:stu){
            System.out.println(s);
        }
    }

}

class Student{
    private String name;
    private int age;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }
    public Student() {
    }
    @Override
    public String toString() {
        return "Student [name=" + name + ", age=" + age + "]";
    }
}
