package chapter4.ex4;

/**
 * 酒店管理
 */
public class Hotel {

    //下面为描述类所属对象的性质和状态的field部分
    private String hotelName;  //酒店名
    private String[][] rooms;	//酒店房间，存储房间的状态（EMPTY/入住客人名）

    /**
     *
     * Hotel()和Hotel(String,Strng[][])为类的构造方法
     */
    public Hotel() {
        super();
    }

    public Hotel(String hotelName) {
        this.hotelName = hotelName;
    }

    public Hotel(String hotelName, String[][] rooms) {
        this(hotelName);   //this()调用已存在的构造方法
        this.rooms = rooms;
    }

    /**
     *
     * setHotelName()和getHotelName()方法为类向外界提供的数据访问接口
     */
    public String getHotelName() {
        return this.hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    /***
     * 以下为类所属对象的行为方法
     */

    public void search(){//查询所有客房状态

    }

    public void search(int roomNo){//查询指定客房状态

    }

    public void in(String customer, int roomNo){ //入住

    }

    public void out(int roomNo){ //退房

    }
    public int compareTo(Hotel anotherHotel){
        int thisRoomsCount = this.rooms.length * this.rooms[0].length;
        int anotherRoomsCount = anotherHotel.rooms.length * anotherHotel.rooms[0].length;
        return thisRoomsCount-anotherRoomsCount;
    }

    public static void main(String[] args){
        Hotel hotel1 = new Hotel("MiniHilton", new String[10][20]);
        Hotel hotel2 = new Hotel("MiniStarwood", new String[15][20]);

        System.out.println(hotel1.getHotelName());  //获取到修改后的hotelName

        int res = hotel1.compareTo(hotel2);
        if(res>0){
            System.out.println("酒店1的房间更多");
        }else if(res<0){
            System.out.println("酒店2的房间更多");
        }else{
            System.out.println("两个酒店的房间一样多");
        }

    }
}
