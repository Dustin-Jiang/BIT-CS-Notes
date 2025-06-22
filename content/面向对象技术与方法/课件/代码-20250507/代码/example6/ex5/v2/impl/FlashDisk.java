package example6.ex5.v2.impl;

import example6.ex5.v2.IMobileStorage;


public class FlashDisk implements IMobileStorage {

    public void read() {
        System.out.println("Reading from FlashDisk⋯⋯");
    }

    public void write() {
        System.out.println("Writing to FlashDisk⋯⋯");
    }

}
