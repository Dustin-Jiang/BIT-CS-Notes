package example11.ex8;

public class Test {

    public static void main(String[] args) {
        Object message = new Object();

        Thread t1 = new Pasta(message);  //共享线程通信的message对象
        Thread t2 = new Pizza(message);  //共享线程通信的message对象

        t1.start();
        t2.start();
    }
}