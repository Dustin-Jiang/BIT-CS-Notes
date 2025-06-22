package example8.set;

import java.util.*;

public class SetDemo {

    public static void main(String[] args) {
        Set<String> set = new HashSet<>();

        set.add("Java");
        set.add("Struts");
        set.add("Spring");
        set.add("Spring");	//该元素将被拒绝添加

        System.out.println(set);	//输出[Struts, Spring, Java],与添加的顺序无关

    }
}
