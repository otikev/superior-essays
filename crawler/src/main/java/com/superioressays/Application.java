package com.superioressays;

import com.superioressays.sweetStudy.Crawler;

/**
 * Created by otikev on 05-Jul-2022
 */

public class Application {

    public static void main(String[] args) {
        Crawler crawler = new Crawler();
        try {
            crawler.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}