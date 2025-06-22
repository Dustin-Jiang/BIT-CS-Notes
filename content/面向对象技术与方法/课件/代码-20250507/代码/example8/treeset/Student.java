package example8.treeset;

public class Student implements Comparable{
    private String name;
    private int age;

    public boolean equals(Object obj){
        if(this==obj)  return true;

        if(obj instanceof Student){
            Student stu = (Student)obj;

            //对象相等的依据是id和name都相同
            return name.equals(stu.name) && age==stu.age ;
        }

        return false;
    }

    public int hashCode(){
        return  name.hashCode()^age^0x5f2ab673;   //原始散列码与大数值进行位运算
    }


    public Student() {
        super();
        // TODO Auto-generated constructor stub
    }

    public Student(String name,int age) {
        super();
        this.age = age;
        this.name = name;
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

    @Override
//	public int compareTo(Object obj) {
//		if(obj instanceof Student){
//			Student stu = (Student)obj;
//			return this.name.compareTo(stu.name);
//		}
//		return 0;
//	}

    public int compareTo(Object obj) {
        if(obj instanceof Student){
            Student stu = (Student)obj;
            if(this.name.equals(stu.name)){
                return this.age-stu.age;
            }else{
                return this.name.compareTo(stu.name);
            }
        }
        return 0;
    }
}
