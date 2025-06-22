package example8.treeset;

import java.util.Comparator;

public class ComparatorNameAge  implements Comparator{

    @Override
    public int compare(Object obj1, Object obj2) {
        if(obj1 instanceof Student && obj2 instanceof Student){
            Student s1=(Student)obj1;
            Student s2=(Student)obj2;
            if(s1.getName().equals(s2.getName())){
                return s1.getAge()-s2.getAge();	//name相同时按age升序排列
            }else{
                return s1.getName().compareTo(s2.getName());	//按name升序排列
            }
        }
        return 0;
    }
}