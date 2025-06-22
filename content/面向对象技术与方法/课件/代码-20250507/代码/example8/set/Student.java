package example8.set;

public class Student {
    private String name;
    private int age;

    public boolean equals(Object obj){
        if(obj==null)	return false;
        if(this==obj)	return true;

        if(obj instanceof Student){
            Student stu = (Student)obj;

            //对象相等的依据是name和age都相同
            return this.name.equals(stu.name) && this.age==stu.age;
        }

        return false;
    }

    public int hashCode(){
        return  name.hashCode()^age^0x5f2ab673;   //散列方法:原始散列码与大数值异或运算
    }

    public Student() {

    }
    public Student(String name, int age) {
        super();
        this.name = name;
        this.age = age;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

