module SEConstants

    module Signals
        USER_LOGIN = 1000
        ORDER_CREATED = 2000
        ORDER_PAID = 2001
        ORDER_COMPLETED = 2002
        ORDER_RETURNED = 2003
        ORDER_CLOSED = 2004
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
end

MESSAGE_TYPE_USER_MESSAGE = 1
MESSAGE_TYPE_STATUS_CHANGE = 2