package example6.tables;

public class Student {
    private int id;
    private String name;
    private boolean gender;
    private int age;

    public Student(int id, String name, boolean gender, int age) {
        super();
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.age = age;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
    public boolean isGender() {
        return gender;
    }
    public void setGender(boolean gender) {
        this.gender = gender;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }



}
