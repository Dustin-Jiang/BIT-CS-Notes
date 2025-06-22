package example8.treeset;

import java.util.*;

public class TreeSetDemo {
    public static void main(String[] args) {
        Set<String> set = new TreeSet<>();
        set.add("Lucy");
        set.add("Hellen");
        set.add("Andrew ");
        System.out.println(set);	//输出[Andrew , Hellen, Lucy]
    }


}

