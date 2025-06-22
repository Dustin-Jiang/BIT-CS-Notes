package example8.map;
import java.util.*;
import java.util.Map.Entry;

public class EntryDemo {

    public static void main(String[] args) {
        Map<String,  Student> map = new HashMap<>();

        map.put("001", new Student("Lucy",20));		//(1)向HashMap中添加键值对
        map.put("002", new Student("Hellen",19));
        map.put("003", new Student("Andrew",21));
        map.put("001", new Student("Jimmy",19));	//键重复，覆盖原键值对

        Set<Entry<String,Student>> entrySet = map.entrySet();	//从map获取键值对集合
        Iterator<Entry<String,Student>> it = entrySet.iterator();
        while(it.hasNext()){
            Entry<String,Student> entry = it.next();	//获取一个键值对对象
            String key = entry.getKey();	//从键值对中获取key
            Student stu = entry.getValue();	//从键值对中获取value
            System.out.println(key+":"+"("+stu.getName()+","+stu.getAge()+")");
        }

    }

}
