package registration;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test {
    public static void main(String[] args) {
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        String.format("%02d", month);
        DateFormat df= new SimpleDateFormat("yyyyMM");
        Date date = new Date();
        String str_time =df.format(date);
        System.out.println(str_time);
    }
}
