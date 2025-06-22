package example11.ex6;

public class SynchronizedTest{
    public synchronized void m1(){
        System.out.println("m1");
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
        }
    }
    public synchronized void m2(){
        System.out.println("m2");
    }

    public static void main(String[] args) {
        SynchronizedTest s = new SynchronizedTest();
        Thread t1 = new MyThread1(s);
        Thread t2 = new MyThread2(s);

        t1.start();
        t2.start();
    }
}
class MyThread1 extends Thread{
    private SynchronizedTest s;

    public MyThread1(SynchronizedTest s) {
        super();
        this.s = s;
    }

    public void run(){
//		SynchronizedTest s = new SynchronizedTest();
        s.m1();
    }
}
class MyThread2 extends Thread{
    private SynchronizedTest s;

    public MyThread2(SynchronizedTest s) {
        super();
        this.s = s;
    }
    public void run(){
        SynchronizedTest s = new SynchronizedTest();
        s.m2();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
        }
    }
}

