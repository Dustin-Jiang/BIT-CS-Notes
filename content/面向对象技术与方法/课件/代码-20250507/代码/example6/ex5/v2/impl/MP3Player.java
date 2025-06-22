package example6.ex5.v2.impl;

import example6.ex5.v2.IMobileStorage;

public class MP3Player implements IMobileStorage {
    public void read() {
        System.out.println("Reading from MP3Player⋯⋯");
    }

    public void write() {
        System.out.println("Writing to MP3Player⋯⋯");
    }

}

