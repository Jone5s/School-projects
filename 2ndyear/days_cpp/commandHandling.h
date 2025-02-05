#pragma once

#include <iostream> // for standard I/O streams
#include <iomanip>  // for stream control
#include <string>   // for std::string class
#include <cstdlib>  // for std::getenv
#include <chrono>   // for the std::chrono facilities
#include <sstream>  // for std::stringstream class
#include <vector>   // for std::vector class
#include <optional> // for std::optional
#include <string_view>  // for std::string_view
#include <filesystem>  // for path utilities
#include <memory>   // for smart pointers
#include <fstream> 

#include "event.h"  // for our Event class
#include "rapidcsv.h"

std::optional<std::chrono::year_month_day> getDateFromString(const std::string& buf) {
    using namespace std;  // use std facilities without prefix inside this function

    constexpr string_view yyyymmdd = "YYYY-MM-DD";
    if (buf.size() != yyyymmdd.size()) {
        return nullopt;
    }

    istringstream input(buf);
    string part;
    vector<string> parts;
    while (getline(input, part, '-')) {
        parts.push_back(part);
    }
    if (parts.size() != 3) {  // expecting three components, year-month-day
        return nullopt;
    }

    int year{0};
    unsigned int month{0};
    unsigned int day{0};
    try {
        year = stoul(parts.at(0));
        month = stoi(parts.at(1));
        day = stoi(parts.at(2));

        auto result = chrono::year_month_day{
            chrono::year{year},
            chrono::month(month),
            chrono::day(day)};

        if (result.ok()) {
            return result;
        }
        else {
            return nullopt;
        }
    }
    catch (invalid_argument const& ex) {
        cerr << "conversion error: " << ex.what() << endl;
    }
    catch (out_of_range const& ex) {
        cerr << "conversion error: " << ex.what() << endl;
    }

    return nullopt;
}

// Returns the value of the environment variable `name` as an `std::optional``
// value. If the variable exists, the value is a wrapped `std::string`,
// otherwise `std::nullopt`.
std::optional<std::string> getEnvironmentVariable(const std::string& name) {
    const char *value = std::getenv(const_cast<char *>(name.c_str()));
    if (nullptr != value) {
        std::string valueString = value;
        return valueString;
    }
    return std::nullopt;
}

// Returns `date` as a string in `YYYY-MM-DD` format.
// The ostream support for `std::chrono::year_month_day` is not
// available in most (any?) compilers, so we roll our own.
std::string getStringFromDate(const std::chrono::year_month_day& date) {
    std::ostringstream result;

    result
        << std::setfill('0') << std::setw(4) << static_cast<int>(date.year())
        << "-" << std::setfill('0') << std::setw(2) << static_cast<unsigned>(date.month())
        << "-" << std::setfill('0') << std::setw(2) << static_cast<unsigned>(date.day());

    return result.str();
}


// Print `T` to standard output.
// `T` needs to have an overloaded << operator.
template <typename T>
void display(const T& value) {
    std::cout << value;
}

// Prints a newline to standard output.
inline void newline() {
    std::cout << std::endl;
}

// Overload the << operator for the Event class.
// See https://learn.microsoft.com/en-us/cpp/standard-library/overloading-the-output-operator-for-your-own-classes?view=msvc-170
std::ostream& operator <<(std::ostream& os, const Event& event) {
    os
        << getStringFromDate(event.getTimestamp()) << ": "
        << event.getDescription()
        << " (" + event.getCategory() + ")";
    return os;
}

// Gets the number of days betweem to time points.
int getNumberOfDaysBetween(std::chrono::sys_days const& earlier, std::chrono::sys_days const& later) {
    return (later - earlier).count();
}

void showAllEvents(const std::vector<Event>& events, const auto today) {
    using namespace std;
    for (auto& event : events) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
    }
}

void showBeforeDate(const std::vector<Event>& events, const auto today, const auto targetDate) {
    using namespace std;
    for (auto& event : events) {
        if (event.getTimestamp() < targetDate) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
        }
    }
}

void showAfterDate(const std::vector<Event>& events, const auto today, const auto targetDate) {
    using namespace std;
    for (auto& event : events) {
        if (event.getTimestamp() > targetDate) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
        }
    }
}

void showBetweenDates(const std::vector<Event>& events, const auto today, const auto targetDate, const auto targetDate2) {
    using namespace std;
    for (auto& event : events) {
        if (event.getTimestamp() > targetDate && event.getTimestamp() < targetDate2) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
        }
    }
}

void showEventsOnDate(const std::vector<Event>& events, const auto today, const auto targetDate) {
    using namespace std;
    for (auto& event : events) {
        if (event.getTimestamp() == targetDate) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
        }
    }
}

void showWithNoCategory(const std::vector<Event>& events, const auto today) {
    using namespace std;
    for (auto& event : events) {
        if (event.getCategory().empty()) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
        }
    }
}

void showEventsByCategory(const std::vector<Event>& events,std::vector<std::string> categories,bool inc,const auto today) {
    using namespace std;
    if (inc == true) {
    for (auto& event : events) {
        if (event.getCategory() == categories[0]) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
            }
        }
    }
    else {
    for (auto& event : events) {
        if (event.getCategory() != categories[0]) {
        const auto delta = (chrono::sys_days{event.getTimestamp()} - today).count();

        ostringstream line;
        line << event << " - ";

        if (delta < 0) {
            line << abs(delta) << " days ago";
        }
        else if (delta > 0) {
            line << "in " << delta << " days";
        }
        else {
            line << "today";
        }

        display(line.str());
        newline();
            }
        }
    }
}

void deleteEventsByDescription(std::vector<Event>& events, const std::string& description, bool dryrun) {
    // Delete events matching the given description
    auto it = std::remove_if(events.begin(), events.end(), [&](const Event& event) {
        return event.getDescription() == description;
    });
    if (dryrun == false) {
    events.erase(it, events.end());
    std::cout << "Event(s) deleted successfully." << std::endl;
    }
    else
    std::cout << "Event(s) deleted successfully." << std::endl;

}

void deleteEventsByCategory(std::vector<Event>& events, const std::string& category, bool dryrun) {
    // Delete events matching the given category
    if (dryrun == false) {
    auto it = std::remove_if(events.begin(), events.end(), [&](const Event& event) {
        return event.getCategory() == category;
    });

        events.erase(it, events.end());
        std::cout << "Event(s) deleted successfully." << std::endl;
    } else {
        std::cout << "Dry run completed successfully, event(s) would have been deleted." << std::endl;
    }

}

void deleteEventsByDate(std::vector<Event>& events, const std::string& date, bool dryrun) {
    // Delete events matching the given date
    auto it = std::remove_if(events.begin(), events.end(), [&](const Event& event) {
        return getStringFromDate(event.getTimestamp()) == date;
    });
    if (dryrun == false) {
    events.erase(it, events.end());
    std::cout << "Event(s) deleted successfully." << std::endl;
    }
    else
    std::cout << "Event(s) deleted successfully." << std::endl;
}

void deleteEventsByDateAndCategory(std::vector<Event>& events, const std::string& date, const std::string& category, bool dryrun) {
    // Delete events matching the given date and category
    auto it = std::remove_if(events.begin(), events.end(), [&](const Event& event) {
        return getStringFromDate(event.getTimestamp()) == date && event.getCategory() == category;
    });
    if (dryrun == false) {
    events.erase(it, events.end());
    std::cout << "Event(s) deleted successfully." << std::endl;
    }
    else
    std::cout << "Event(s) deleted successfully." << std::endl;
}

void deleteEventsByDateCategoryAndDescription(std::vector<Event>& events, const std::string& date, const std::string& category, const std::string& description, bool dryrun) {
    // Delete events matching the given date, category, and description
    auto it = std::remove_if(events.begin(), events.end(), [&](const Event& event) {
        return getStringFromDate(event.getTimestamp()) == date && event.getCategory() == category && event.getDescription() == description;
    });
    if (dryrun == false) {
    events.erase(it, events.end());
    std::cout << "Event(s) deleted successfully." << std::endl;
    }
    else
    std::cout << "Event(s) deleted successfully." << std::endl;
}

void deleteAllEvents(std::vector<Event>& events, bool dryrun) {
    // Delete all events
    if (dryrun == false){
    events.clear();
    std::cout << "Event(s) deleted successfully." << std::endl;
    }
    else
    std::cout << "Events(s) deleted successfully." << std::endl;

}
