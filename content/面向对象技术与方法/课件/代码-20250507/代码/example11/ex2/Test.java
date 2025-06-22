package example11.ex2;

public class Test {
    public static void main(String[] args) {
        Runnable target = new SecondThread();
        Thread t1 = new Thread(target);
        Thread t2 = new Thread(target);
        for(int i=0; i<5; i++){
            System.out.println(Thread.currentThread().getName()+" :  "+i);
            try {
                Thread.sleep(400);	//休眠400毫秒
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if(i==1) t1.start();
            if(i==2) t2.start();
        }
    }

}
