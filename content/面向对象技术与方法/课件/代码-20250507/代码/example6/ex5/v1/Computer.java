package example6.ex5.v1;

public class Computer {

    public void readDataFromFlash(){
        FlashDisk fd = new FlashDisk();
        fd.read();
    }
    public void writeDataFlash(){
        FlashDisk fd = new FlashDisk();
        fd.write();
    }

    public void readDataFromMobileHard(){
        MobileHardDisk mhd = new MobileHardDisk();
        mhd.read();
    }
    public void writeDataMobileHard(){
        MobileHardDisk mhd = new MobileHardDisk();
        mhd.write();
    }
    public void readDataFromMP3(){
        MP3Player mp3 = new MP3Player();
        mp3.read();
    }
    public void writeDataMp3(){
        MP3Player mp3 = new MP3Player();
        mp3.write();
    }

}
