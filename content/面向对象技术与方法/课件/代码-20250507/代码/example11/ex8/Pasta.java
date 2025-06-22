package example11.ex8;

public class Pasta extends Thread{
    private Object message;

    public Pasta(Object message) {
        this.message = message;
    }

    public void run(){
        synchronized(message){
            for(int i=1; i<=20; i++){
                System.out.println(this.getName()+"完成一份意大利面... ");
                if(i%2==0){  //完成任务
                    System.out.println("该你做披萨了...");
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

}