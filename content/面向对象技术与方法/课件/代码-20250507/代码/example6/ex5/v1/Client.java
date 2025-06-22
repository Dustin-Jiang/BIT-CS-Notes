package example6.ex5.v1;

public class Client {

    public static void main(String[] args) {
        Computer computer= new Computer();

        computer.readDataFromFlash();
        computer.readDataFromMobileHard();
        computer.readDataFromMP3();
    }

}

