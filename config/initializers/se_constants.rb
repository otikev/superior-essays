module SEConstants

    module Signals
        #User signals
        USER_LOGIN = 1000
        USER_SIGNUP = 1001

        #Order signals
        ORDER_CREATED = 2000
        ORDER_PAID = 2001
        ORDER_COMPLETED = 2002
        ORDER_RETURNED = 2003
        ORDER_CLOSED = 2004

        #System signals
        EMAILS_QUEUED = 3000
    end

    module AcademicLevelDelta
        HIGHSCHOOL = 0
        COLLEGE = 2
        UNIVERSITY = 3
        MASTERS = 4
        PHD = 5
    end

    module OrderBasePrice
        STANDARD = 13
        PREMIUM = 15
        PLATINUM = 17
    end

    module ContentType
        ARCHIVE = 1
        SAMPLE = 2
    end

    module UserSettings
        EMAIL_UPDATES = "email_updates"
    end

    SUPPORT_EMAIL = "superioressayspro@gmail.com"
end

MESSAGE_TYPE_USER_MESSAGE = 1
MESSAGE_TYPE_STATUS_CHANGE = 2