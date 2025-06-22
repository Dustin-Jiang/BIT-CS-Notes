package example8.map;

import java.util.*;

public class HashMapDemo {

    public static void main(String[] args) {
        Map<String, Student> students = new HashMap<>();

        students.put("001", new Student("Lucy",20));		//(1)向HashMap中添加键值对
        students.put("002", new Student("Hellen",19));
        students.put("003", new Student("Andrew",21));
        students.put("001", new Student("Jimmy",19));	//键重复，覆盖原键值对
        students.putIfAbsent("001", new Student("WanLi", 19));  //键已存在，新增不成功

        Student s1 = students.get("001");		//(2)按键读取数据
        System.out.println(s1.getName()+", "+s1.getAge());	//输出Jimmy,19

        Student s2 = students.getOrDefault("677", new Student("WanLi", 19));
        System.out.println(s2.getName()+", "+s2.getAge());

//		students.remove("002");	//(3)按键删除数据
//		System.out.println(students.size());	//(4)输出键值对的个数

        Set<String> keys = students.keySet();	//(1)取出map中的键集
        Iterator<String> it = keys.iterator();
        while(it.hasNext()){
            String key = it.next();
            Student stu = students.get(key);  //(2)按键从map中获取对应的值
            System.out.println(key+":"+"("+stu.getName()+","+stu.getAge()+")");
        }
    }

}
