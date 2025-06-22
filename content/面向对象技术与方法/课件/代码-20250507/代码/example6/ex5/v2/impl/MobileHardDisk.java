package example6.ex5.v2.impl;

import example6.ex5.v2.IMobileStorage;


public class MobileHardDisk implements IMobileStorage {

    public void read() {
        System.out.println("Reading from MobileHardDisk⋯⋯");

    }

    public void write() {
        System.out.println("Writing to MobileHardDisk");

    }

}

