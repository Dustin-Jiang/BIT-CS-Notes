package chapter4.ex2;

public class Hotel {
    private String hotelName;  //酒店名
    private String[][] rooms;	//酒店房间，存储房间的状态（EMPTY/入住客人名）


    public Hotel() {
        super();
    }

    public Hotel(String hotelName, String[][] rooms) {
        super();
        this.hotelName = hotelName;
        this.rooms = rooms;
    }

    public int compareTo(Hotel anotherHotel){
        int thisRoomsCount = this.rooms.length * this.rooms[0].length;
        int anotherRoomsCount = anotherHotel.rooms.length * anotherHotel.rooms[0].length;
        return thisRoomsCount-anotherRoomsCount;
    }

    public static void main(String[] args) {
        Hotel hotel1 = new Hotel("MiniHilton", new String[10][20]);
        Hotel hotel2 = new Hotel("MiniStarwood", new String[15][20]);
        int res = hotel1.compareTo(hotel2);

        if(res>0){
            System.out.println("酒店1的房间更多 ");
        }else if(res<0){
            System.out.println("酒店2的房间更多");
        }else{
            System.out.println("两个酒店的房间一样多");
        }
    }
}
