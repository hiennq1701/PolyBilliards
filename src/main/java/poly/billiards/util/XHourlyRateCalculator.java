/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.util;


import poly.billiards.util.*;
import java.util.Timer;
import java.util.TimerTask;
/**
 *
 * @author MINH DANG
 */
public class XHourlyRateCalculator {
    private double hourlyRate = 1000.0; // Giá tiền mỗi phút (1k/phút)
    private float totalAmount = 0;
    private Timer timer;

    public XHourlyRateCalculator() {
    }
    
    public void startTimer() {
        timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                addHourlyRate();
            }
        }, 0, 60 * 1000); // Cộng tiền mỗi 1 phút (60 * 1000 milliseconds)
    }
    
     private void addHourlyRate() {
        totalAmount += hourlyRate;
    }
     
     public void stopTimer() {
        if (timer != null) {
            timer.cancel();
        }
    }
     
    public float getTotalAmount() {
        return totalAmount;
    }

    public void reset() {
        totalAmount = 0;
        if (timer != null) {
            timer.cancel();
        }
    }
}
