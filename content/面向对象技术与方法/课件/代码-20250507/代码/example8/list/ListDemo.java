package example8.list;


import java.util.*;

public class ListDemo {

    public static void main(String[] args) {
        List<String> list = new ArrayList<>();

        list.add("Java");
        list.add("Spring");
        list.add(2,"Spring MVC");	//add()方法按索引位置插入元素，元素可重复
        System.out.println(list);  //输出[Java, Spring, Spring MVC]

        list.set(0, "Mybatis");	//set()方法按索引位置对元素进行赋值

        //用索引位置控制循环实现遍历
        for(int i=0; i<list.size(); i++){
            System.out.println(list.get(i));  //get()方法按索引位置获取元素
        }

        list.remove(0);	//remove()方法按索引删除元素
        System.out.println(list);  //输出[Spring, Spring MVC]

        System.out.println(list.indexOf("Mybatis"));  //输出-1
        System.out.println(list.indexOf("Spring"));  //输出0
    }

}
