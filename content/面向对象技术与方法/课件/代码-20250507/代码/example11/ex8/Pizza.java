package example11.ex8;

public class Pizza extends Thread{
    private Object message;

    public Pizza(Object message) {
        this.message = message;
    }

    public void run(){
        synchronized(message){
            for(int i=0; i<10; i++){
                System.out.println(this.getName()+":完成一个披萨... ");
                System.out.println("该你做意大利面了...");

                message.notifyAll();  //唤醒其他线程
                try {
                    message.wait();   //释放锁，等待
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

