package chapter5.ex7.v1;

public class Student {
    private String name;
    private int age;

    public Student() {
    }

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String toString(){
        return name+","+age;
    }
}
