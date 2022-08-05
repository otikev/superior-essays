package com.superioressays.sweetStudy;

import com.superioressays.Scheduler;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by otikev on 24-Jul-2022
 */

public class Crawler {
    private static final Logger logger = Logger.getLogger(Crawler.class);
    String url = "https://www.sweetstudy.com";

    String[] FIELDS = new String[]{
            "/fields/applied-sciences",
            "/fields/biology",
            "/fields/business-finance",
            "/fields/computer-science",
            "/fields/earth-science-geography",
            "/fields/earth-science-geology",
            "/fields/education",
            "/fields/english",
            "/fields/environmental-science",
            "/fields/government",
            "/fields/history",
            "/fields/human-resource-management",
            "/fields/information-systems",
            "/fields/law",
            "/fields/literature",
            "/fields/nursing",
            "/fields/physics",
            "/fields/political-science",
            "/fields/psychology",
            "/fields/reading",
            "/fields/science",
            "/fields/social-science"
    };

    public void start(String hostname) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    for (String field : FIELDS) {
                        parse(field);
                    }
                    Network.notifyBatchComplete(hostname);
                    Scheduler.schedule();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    private void parse(String field) throws IOException {
        logger.info("Parsing field : " + field);

        Document doc = Jsoup.connect(url + field).get();
        Elements section = doc.getElementsByTag("section");
        Elements divs = section.get(0).select("> div");
        Elements uls = divs.get(0).select("> ul");

        if (uls.size() < 5) {
            throw new RuntimeException("Invalid element count");
        }
        List<Question> questions = new ArrayList<>();

        for (int i = 5; i < uls.size(); i++) {
            Element ul = uls.get(i);
            Elements lis = ul.select("> li");
            for (Element li : lis) {
                Element element = li.select(">div>div").get(0);
                Element href = element.select(">a").get(0);
                String targetUrl = url + href.attr("href");
                String title = href.text();

                Question question = new Question();
                question.targetUrl = targetUrl;
                question.title = title;
                questions.add(question);
            }
        }

        //Fetch the first 3 questions that have no attachments
        List<Question> noAttachments = new ArrayList<>();
        for (Question question : questions) {
            Document _doc = Jsoup.connect(question.targetUrl).get();
            Elements mainQuestion = _doc.select("div#main-question");
            Elements questionDetails = mainQuestion.select(">section").get(0).select(">div");
            question.description = questionDetails.get(2).select(">div>div").text();
            Elements attachments = questionDetails.get(3).select(">div>ul>li");
            if (attachments.isEmpty()) {
                //no attachments
                boolean exists = Network.questionExists(question.targetUrl);
                if (exists) {
                    logger.info("Already exists in DB, Skipping...");
                } else {
                    noAttachments.add(question);
                    if (noAttachments.size() >= 3) {
                        break;
                    }
                }
            }
        }

        // Post the questions
        for (Question question : noAttachments) {
            boolean success = Network.createQuestion(question);
            logger.info("Success = " + String.valueOf(success).toUpperCase() + " : " + question.targetUrl);
        }
    }
}
