package example8.list;

import java.util.ArrayList;

import java.util.Collection;
import java.util.Iterator;

public class RemoveDemo {

    public static void main(String[] args) {
        Collection<String> c = new ArrayList<>();	//创建一个ArrayList对象

        //向ArrayList中存放元素
        c.add("Java");
        c.add("Struts");
        c.add("Spring");
        System.out.println(c);

        Iterator<String> it = c.iterator();   //(1)iterator()方法获取迭代器

        while (it.hasNext()){  //(2)hasNext()方法控制迭代
            String element = (String)it.next();	//(3)next()方法获取迭代元素
            if(element.equals("Java")){
                it.remove();	//正常
//				c.remove(element);   //报错
            }
        }
        System.out.println(c);
    }
}
