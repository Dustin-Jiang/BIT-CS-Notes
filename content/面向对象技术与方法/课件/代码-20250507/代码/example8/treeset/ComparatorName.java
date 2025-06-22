package example8.treeset;

import java.util.Comparator;

public class ComparatorName implements Comparator{

    @Override
    public int compare(Object obj1, Object obj2) {
        if(obj1 instanceof Student && obj2 instanceof Student){
            Student s1=(Student)obj1;
            Student s2=(Student)obj2;
            return s1.getName().compareTo(s2.getName());	//按name进行比较
        }
        return 0;
    }
}
