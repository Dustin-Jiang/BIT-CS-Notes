package chapter5.ex7.v2;

public class Student implements Cloneable{
    private String name;
    private int age;

    public Student() {
    }
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public Student clone() throws CloneNotSupportedException{ //重写Object类的clone()方法
        return (Student)super.clone();  //调用Object类的clone()功能完成复制
    }

    public String toString(){
        return name+","+age;
    }
}
