package chapter5.ex7.v3;

public class Teacher implements Cloneable{
    private String name;

    public Teacher(String name) {
        this.name = name;
    }
    public Teacher() {
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
 //public Teacher clone() throws CloneNotSupportedException{//重写clone方法
 //return (Teacher)super.clone();
    //}
}
