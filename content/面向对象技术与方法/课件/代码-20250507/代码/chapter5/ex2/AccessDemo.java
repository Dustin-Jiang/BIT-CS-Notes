package chapter5.ex2;

public class AccessDemo {
    public static void  main(String[] args) {
        A coo = new A();	//类A与AccessDemo类在同包下

        System.out.println(coo.a);  //可以类A的public成员
        System.out.println(coo.b);	//可以类A的protected成员
        System.out.println(coo.c);	//可以类A的package成员

        //System.out.println(coo.d);	//不可以类A的private成员
        System.out.println(coo.getD());	//可以通过public接口获取private成员

        coo.t();
    }
}
