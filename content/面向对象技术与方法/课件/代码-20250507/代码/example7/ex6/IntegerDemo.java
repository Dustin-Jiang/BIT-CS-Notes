package example7.ex6;
public class IntegerDemo {

    /**
     * @param args
     */
    public static void main(String[] args) {
        int i2 =200;
        String s = "300";

        Integer i1 = new Integer(100);	//int->Integer
        System.out.println(Integer.valueOf(i2));  //int->Integer
        System.out.println(i1.intValue());  //Integer->int

        System.out.println(i2+""); //int->String(1)
        System.out.println(Integer.toString(i2));	//int->String
        System.out.println(Integer.parseInt(s));  //String->int

        System.out.println(i1+""); //Integer->String
        System.out.println(i1.toString()); //Integer->String
        System.out.println(new Integer("400"));   //String->Integer
        System.out.println(Integer.valueOf("400"));  //String->Integer
    }

}
