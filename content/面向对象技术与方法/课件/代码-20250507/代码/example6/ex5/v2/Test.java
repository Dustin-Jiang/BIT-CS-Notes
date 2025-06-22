package example6.ex5.v2;

import example6.ex5.v2.impl.FlashDisk;
import example6.ex5.v2.impl.MP3Player;
import example6.ex5.v2.impl.MobileHardDisk;

public class Test {
    public static void main(String[] args) {

        Computer computer = new Computer();

        IMobileStorage fd = new FlashDisk();
        IMobileStorage mhd = new MobileHardDisk();
        IMobileStorage mp3 = new MP3Player();

        computer.setUsbDriver(fd);
        computer.readData();
        computer.wrietData();

        computer.setUsbDriver(mhd);
        computer.readData();
        computer.wrietData();

        computer.setUsbDriver(mp3);
        computer.readData();
        computer.wrietData();

    }
}

