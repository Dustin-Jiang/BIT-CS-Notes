package example8.iterator;


import java.util.ArrayList;

import java.util.Collection;
import java.util.Iterator;

public class IteratorDemo {

    public static void main(String[] args) {
        Collection c = new ArrayList();	//创建一个ArrayList对象

        //向集合中存放元素
        c.add("Java");
        c.add("Struts");
        c.add("Spring");

        //迭代方式1
        Iterator it = c.iterator();   //(1)iterator()方法获取迭代器
//		while (it.hasNext()){  //(2)hasNext()方法控制迭代
//			String element = (String)it.next();	//(3)next()方法获取迭代元素
//			System.out.println(element);
//		}

        //迭代方式2: foreach循环
//		for(Object element: c){
//			String str = (String)element;
//			System.out.println(str);
//		}

        //直接打印集合，调用Collection重写的toString()方法
        System.out.println(c);

        //迭代方式3：forEach()，lambda表达式做参数
        c.forEach( ele -> System.out.println(ele) );
        c.forEach( (ele) -> {System.out.println(ele);} );


        //迭代方式4：forEachRemaining()，lambda表达式做参数
        it = c.iterator();  //重新获取迭代器（从头开始迭代）
        it.forEachRemaining(ele -> System.out.println(ele));  //lambda表达式做参数


        //remove和next的配合使用
        it = c.iterator();
        it.next();
        it.remove();
//		it.remove();   //报错
    }
}
