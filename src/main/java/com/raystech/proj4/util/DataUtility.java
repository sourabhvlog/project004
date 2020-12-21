package com.raystech.proj4.util;

import com.raystech.proj4.util.DataValidator;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Data Utility class to format data from one format to another
 * 
 * @author SunilOS
 * @version 1.0
 * @Copyright (c) SunilOS
 */

public class DataUtility {

    /**
     * Application Date Format
     */
    public static final String APP_DATE_FORMAT = "MM/dd/yyyy";
    
    
    public static final String SERCH_DATE_FORMAT = "yyyy-MM-dd";
    

    public static final String APP_TIME_FORMAT = "MM/dd/yyyy HH:mm:ss";

    /**
     * Date formatter
     */
    private static final SimpleDateFormat formatter = new SimpleDateFormat(
            APP_DATE_FORMAT);
    
    private static final SimpleDateFormat formatter2 = new SimpleDateFormat(SERCH_DATE_FORMAT);

    private static final SimpleDateFormat timeFormatter = new SimpleDateFormat(
            APP_TIME_FORMAT);

    /**
     * Trims and trailing and leading spaces of a String
     * 
     * @param val
     * @return
     */
    public static String getString(String val) {
        if (DataValidator.isNotNull(val)) {
            return val.trim();
        } else {
            return val;
        }
    }

    /**
     * Converts and Object to String
     * 
     * @param val
     * @return
     */
    public static String getStringData(Object val) {
        if (val != null) {
            return val.toString();
        } else {
            return "";
        }
    }

    /**
     * Converts String into Integer
     * 
     * @param val
     * @return
     */
    public static int getInt(String val) {
        if (DataValidator.isInteger(val)) {
            return Integer.parseInt(val);
        } else {
            return 0;
        }
    }

    /**
     * Converts String into Long
     * 
     * @param val
     * @return
     */
    public static long getLong(String val) {
        if (DataValidator.isLong(val)) {
            return Long.parseLong(val);
        } else {
            return 0;
        }
    }

    /**
     * Converts String into Date
     * 
     * @param val
     * @return
     */
    public static Date getDate(String val) {
        Date date = null;
        try {
            date = formatter.parse(val);
        } catch (Exception e) {

        }
        return date;
    }

    /**
     * Converts Date into String
     * 
     * @param date
     * @return
     */
    public static String getDateString(Date date) {
        try {
            return formatter.format(date);
        } catch (Exception e) {
        }
        return "";
    }
    
    public static String getDateString2(Date date) {
		try {
			return formatter2.format(date);
		}catch (Exception e) {
			return "";
		}
	}

    /**
     * Gets date after n number of days
     * 
     * @param date
     * @param day
     * @return
     */
    public static Date getDate(Date date, int day) {
        return null;
    }

    /**
     * Converts String into Time
     * 
     * @param val
     * @return
     */
    public static Timestamp getTimestamp(String val) {

        Timestamp timeStamp = null;
        try {
            timeStamp = new Timestamp((timeFormatter.parse(val)).getTime());
        } catch (Exception e) {
            return null;
        }
        return timeStamp;
    }

    public static Timestamp getTimestamp(long l) {

        Timestamp timeStamp = null;
        try {
            timeStamp = new Timestamp(l);
        } catch (Exception e) {
            return null;
        }
        return timeStamp;
    }

    public static Timestamp getCurrentTimestamp() {
        Timestamp timeStamp = null;
        try {
            timeStamp = new Timestamp(new Date().getTime());
        } catch (Exception e) {
        }
        return timeStamp;

    }

    public static long getTimestamp(Timestamp tm) {
        try {
            return tm.getTime();
        } catch (Exception e) {
            return 0;
        }
    }
    
    public static String passOrNot(int marks) {
    	if(marks >= 35) {
    		return "<font style=\"font-weight: bold;\">PASS</font>"; 
    	}else {
    		return "<font style=\"font-weight: bold;\">FAIL</font>";
    	}
	}
    
    public static String result(double per, int phy, int che, int math) {
    	if(per>=35 && phy>=35 && che>=35 && math>=35) {
    		return "<font style=\"font-weight: bold;\">PASS</font>";
    	}
    	else {
    		return "<font style=\"font-weight: bold;\">FAIL</font>";
    	}
    }

    public static void main(String[] args) {
        System.out.println(getInt("124"));
        String res = passOrNot(20);
        System.out.println(res);
        String res2 = passOrNot(35);
        System.out.println(res2);
        String res3 = passOrNot(50);
        System.out.println(res3);
    }

}
