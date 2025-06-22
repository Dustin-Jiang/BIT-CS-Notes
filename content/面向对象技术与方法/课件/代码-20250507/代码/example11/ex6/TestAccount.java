package example11.ex6;

public class TestAccount {
    public static void main(String[] args) {
        Runnable target = new MyRunnable(new Account(5000));

        Thread t1 = new Thread(target, "wife");
        Thread t2 = new Thread(target, "husband");

        t1.start();
        t2.start();
    }
}
