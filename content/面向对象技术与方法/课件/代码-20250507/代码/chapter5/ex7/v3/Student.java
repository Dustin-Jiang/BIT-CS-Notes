package chapter5.ex7.v3;

public class Student implements Cloneable{
    private String name;
    private int age;
    private Teacher teacher;//增加Teacher类型的引用成员

    public Student(String name, int age, Teacher teacher) {
        this.name = name;
        this.age = age;
        this.teacher = teacher;
    }
    public Student() {
    }

    public Teacher getTeacher() {
        return teacher;
    }
    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public Student clone() throws CloneNotSupportedException{
        Student stu = (Student)super.clone();
    //this.teacher = (Teacher)stu.getTeacher().clone();
        return stu;
    }

    public String toString(){
        return name+","+age+","+teacher.getName();
    }


}
